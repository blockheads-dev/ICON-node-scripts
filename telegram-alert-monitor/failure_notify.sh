#!/bin/bash
read_last_message() {
	local RFILE=./data
	local UNIXEPOCH=`date +"%s"`
	if [ -f "$RFILE" ]; then
		local LMESSAGE=`cat $RFILE | grep "M" | awk -F ":" '{print $2}'`
	else
		touch ./data && echo "M:9:$UNIXEPOCH" > ./data
		local RFILE=./data
		local LMESSAGE=`cat $RFILE | grep "M" | awk -F ":" '{print $2}'`
	fi
	echo $LMESSAGE
}

check_url() {
	local CHECKED=`curl --insecure --connect-timeout 6 -s -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "icx_getLastBlock", "id": 1234}' http://$IPN/api/v3 | jq .result.height`
	if [ -z $CHECKED ]; then
		local RDATA='0'
	else
		local RDATA='1'
	fi
	echo $RDATA
}

error_messages() {
	case "$ISUP" in
    0)
        local MES="Node API is OFFLINE" ;;
    1)
        local MES="Node API is ONLINE" ;;
	3)
		local MES="Node is STUCK" ;;
	esac
	echo $MES
}

send_telegram_message() {
	case "$ISUP" in
	0)
		curl -s -X POST https://api.telegram.org/bot$BOTNUMBER/sendMessage -d chat_id=$ALERTCHATID -d text="☠️ Node $NAME IP: $IPN doesn't work and may be OFFLINE. Please check http://$IPN/api/v1/status/peer";;
	1)
		curl -s -X POST https://api.telegram.org/bot$BOTNUMBER/sendMessage -d chat_id=$ALERTCHATID -d text="❤️ Node $NAME IP: $IPN is back ONLINE. Please check http://$IPN/api/v1/status/peer";;
	3)
		BLOCKHEIGHT_3RDPARTY=`./getblockheight.sh`
		curl -s -X POST https://api.telegram.org/bot$BOTNUMBER/sendMessage -d chat_id=$ALERTCHATID -d text="❤️ Node $NAME IP: $IPN stopped at block $CHECKED. $BLOCKHEIGHT_3RDPARTY. Please check http://$IPN/api/v1/status/peer";;
	esac
}

main_loop() {
	while true; do
		NODEIP=`cat ${PWD}/config.ini | grep -v "#" | grep "NODE"`
		for IP in $NODEIP
		do
			NAME=`echo $IP |awk -F ";" '{print $1}' | sed 's/NODE=//g'`
			IPN=`echo $IP | awk -F ";" '{print $2}'`
			LAST_MESSAGE=$(read_last_message)
			UNIXEPOCH=`date +"%s"`
			ISUP=$(check_url $IP)
			 if [ -z $ISUP ]; then
				ISUP=$(check_url $IP)
			fi
			if [ $ISUP == $LAST_MESSAGE ]; then
				ERR=$(error_messages $ISUP)
				MESSAGE="$ERR - DUPLICATE MESSAGE : DID NOT SEND"
			else
				MESSAGE=$(error_messages $ISUP)
				send_telegram_message 1
				echo "M:$ISUP:$UNIXEPOCH" > ./data
			fi

			echo $MESSAGE

		done
		sleep 10;
	done
}

CHATID=`cat ${PWD}/config.ini | grep -v "#" | grep "CHATID" | awk -F "=" '{print $2}'`
ALERTCHATID=`cat ${PWD}/config.ini | grep -v "#" | grep "ALERTCHATID" | awk -F "=" '{print $2}'`
BOTNUMBER=`cat ${PWD}/config.ini | grep -v "#" | grep "BOTNUMBER" | awk -F "=" '{print $2}'`
PWD=$PWD

main_loop
