#!/bin/bash
PWD=$PWD
NODEIP=`cat ~/custom-commands-config/ip_list.ini | grep -v "#" | grep "NODE"`

get_zicon_status() {
        echo "Testing zicon.solidwallet.io"
        BLOCKHEIGHT=`curl --insecure --connect-timeout 6 -s -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "icx_getLastBlock", "id": 1234}' https://zicon.tracker.solidwallet.io:443/api/v3  | jq .result.height`
        if [ -z $BLOCKHEIGHT ]; then
                DATA="(zicon.solidwallet Maybe API Offline)"
        else
                DATA="(zicon.solidwallet API Online). Current Block height is $BLOCKHEIGHT"
        fi
        echo $DATA
}

get_zicon_status

for IP in $NODEIP
        do
                NAME=`echo $IP |awk -F ";" '{print $1}' | sed 's/NODE=//g'`
                IPN=`echo $IP | awk -F ";" '{print $2}'`
                #VERSION=`echo $IP | awk -F ";" '{print $3}'`
                TEXT=`curl --insecure --connect-timeout 6 -s "http://$IPN/api/v1/status/peer" | jq '.block_height, .status'`
                echo "$IPN $TEXT"
        done
