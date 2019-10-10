#Get blockheight from zicon.tracker.solidwallet.io
curl --insecure --connect-timeout 6 -s -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "icx_getLastBlock", "id": 1234}' https://zicon.tracker.solidwallet.io:443/api/v3 | jq .result.height
