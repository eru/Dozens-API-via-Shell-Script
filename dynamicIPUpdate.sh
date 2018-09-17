#!/bin/bash

echo "Dozens dynamic IP setter version 0.3b mod"

# Variable check
ERROR=""
if [ -z "$X_AUTH_USER" ]; then
  echo "Require X_AUTH_USER: Username. (e.g. johnappleseed)"
  ERROR="1"
fi
if [ -z "$X_AUTH_KEY" ]; then
  echo "Require X_AUTH_KEY: API key. (e.g. 123abc456def789ghi)"
  ERROR="1"
fi
if [ -z "$ZONE" ]; then
  echo "Require ZONE: Zone name. (e.g. example.com)"
  ERROR="1"
fi
if [ -z "$DOMAIN" ]; then
  echo "Require DOMAIN: domain name. (e.g. www.example.com)"
  ERROR="1"
fi
if [ -z "$DEVICE" ]; then
  echo "Require DEVICE: ethernet device. (e.g. eth0)"
  ERROR="1"
fi
if [ -n "$ERROR" ]; then
  echo 'usage: X_AUTH_USER="johnappleseed" X_AUTH_KEY="123abc456def789ghi" ZONE="example.com" DOMAIN="www.example.com" DEVICE="eth0" dynamicIPUpdate.sh'
  exit 1
fi

# Get Global IP address
GLOBALIPV4=$(curl --interface $DEVICE -s http://v4.ipv6-test.com/api/myip.php)
echo "Your global IPv4 is $GLOBALIPV4"
GLOBALIPV6=$(curl --interface $DEVICE -s http://v6.ipv6-test.com/api/myip.php)
echo "Your global IPv6 is $GLOBALIPV6"$'\n'

# Auth initialization
echo "Auth initialization start."
MYKEY=$(curl -s http://dozens.jp/api/authorize.json -H X-Auth-User:$X_AUTH_USER -H X-Auth-Key:$X_AUTH_KEY | jq -r '.auth_token')
echo "Your key is : $MYKEY"$'\n'

# Get domain records
echo "Getting $ZONE records..."$'\n'
JSON=$(curl -s http://dozens.jp/api/record/$ZONE.json -H X-Auth-Token:$MYKEY)

# Get server a record id
echo "Serching $DOMAIN A record..."
RECORD_ID=$(echo $JSON | jq -r '.record[] | select(.name == "$DOMAIN") | select(.type == "A") | .id')
echo "$DOMAIN A record id is $RECORD_ID""."$'\n'

# Set IP Address
echo "Recode update in progress..."
RESULT=$(curl -s -d "{\"prio\":\"\", \"content\":\"$GLOBALIPV4\", \"ttl\":\"7200\"}" http://dozens.jp/api/record/update/$RECORD_ID.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json" | jq -r ".record[] | select(.id == \"$RECORD_ID\")")
echo "Dozens server says : $RESULT"$'\n'

# Get server aaaa record id
echo "Serching $DOMAIN AAAA record..."
RECORD_ID=$(echo $JSON | jq -r '.record[] | select(.name == "$DOMAIN") | select(.type == "AAAA") | .id')
echo "$DOMAIN AAAA record id is $RECORD_ID""."$'\n'

# Set IP Address
echo "Recode update in progress..."
RESULT=$(curl -s -d "{\"prio\":\"\", \"content\":\"$GLOBALIPV6\", \"ttl\":\"7200\"}" http://dozens.jp/api/record/update/$RECORD_ID.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json" | jq -r ".record[] | select(.id == \"$RECORD_ID\")")
echo "Dozens server says : $RESULT"$'\n'

echo "Script is done!"$'\n'
