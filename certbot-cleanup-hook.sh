#!/bin/bash

DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"

echo "Dozens certbot DNS-01 challenge cleanup"

# Auth initialization
echo "Auth initialization start."
MYKEY=$(curl -s http://dozens.jp/api/authorize.json -H X-Auth-User:$X_AUTH_USER -H X-Auth-Key:$X_AUTH_KEY | jq -r '.auth_token')
echo "Your key is : $MYKEY"$'\n'

# Get domain records
echo "Getting $DOMAIN records..."$'\n'
JSON=$(curl -s http://dozens.jp/api/record/$ZONE.json -H X-Auth-Token:$MYKEY)

# Search acme-challenge txt record id
echo "Serching $DOMAIN acme-challenge TXT record..."
RECORDID=$(echo $JSON | jq -r ".record[] | select(.name == \"$DOMAIN\") | select(.type == \"TXT\") | .id")
if [ -n "$RECORDID" ]; then
  echo "$DOMAIN TXT record id is $RECORDID""."$'\n'

  # Delete record
  echo "Recode delete in progress..."
  RESULT=$(curl -s -X DELETE http://dozens.jp/api/record/delete/$RECORDID.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json")
else
  echo "$DOMAIN TXT record id does not exist."$'\n'
fi

echo "Script is done!"$'\n'
