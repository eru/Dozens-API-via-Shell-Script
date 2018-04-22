#!/bin/bash

# KEYWORDS
USERNAME="username"
XAUTHKEY="authkey"
DOMAINNAME="domainname"
SERVERNAME="servername"
DEVICE="eth0"

echo "Dozens dynamic IP setter version 0.3b mod"

# Get Global IP address
GLOBALIPV4=$(curl --interface $DEVICE -s http://v4.ipv6-test.com/api/myip.php)
echo "Your global IPv4 is $GLOBALIPV4"
GLOBALIPV6=$(curl --interface $DEVICE -s http://v6.ipv6-test.com/api/myip.php)
echo "Your global IPv6 is $GLOBALIPV6"$'\n'

# Auth initialization
echo "Auth initialization start."
MYKEY=$(curl -s http://dozens.jp/api/authorize.json -H X-Auth-User:$USERNAME -H X-Auth-Key:$XAUTHKEY | jq -r '.auth_token')
echo "Your key is : $MYKEY"$'\n'

# Get domain records
echo "Getting $SERVERNAME records..."$'\n'
JSON=$(curl -s http://dozens.jp/api/record/$DOMAINNAME.json -H X-Auth-Token:$MYKEY)

# Get server a record id
echo "Serching $SERVERNAME A record..."
RECORDID=$(echo $JSON | jq -r '.record[] | select(.name == "$SERVERNAME") | select(.type == "A") | .id')
echo "$SERVERNAME A record id is $RECORDID""."$'\n'

# Set IP Address
echo "Recode update in progress..."
RESULT=$(curl -s -d "{\"prio\":\"\", \"content\":\"$GLOBALIPV4\", \"ttl\":\"7200\"}" http://dozens.jp/api/record/update/$RECORDID.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json" | jq -r ".record[] | select(.id == \"$RECORDID\")")
echo "Dozens server says : $RESULT"$'\n'

# Get server aaaa record id
echo "Serching $SERVERNAME AAAA record..."
RECORDID=$(echo $JSON | jq -r '.record[] | select(.name == "$SERVERNAME") | select(.type == "AAAA") | .id')
echo "$SERVERNAME AAAA record id is $RECORDID""."$'\n'

# Set IP Address
echo "Recode update in progress..."
RESULT=$(curl -s -d "{\"prio\":\"\", \"content\":\"$GLOBALIPV6\", \"ttl\":\"7200\"}" http://dozens.jp/api/record/update/$RECORDID.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json" | jq -r ".record[] | select(.id == \"$RECORDID\")")
echo "Dozens server says : $RESULT"$'\n'

echo "Script is done!"$'\n'
