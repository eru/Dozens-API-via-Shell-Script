#!/bin/bash

DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"

echo "Dozens certbot DNS-01 challenge auth"

# Auth initialization
echo "Auth initialization start."
MYKEY=$(curl -s http://dozens.jp/api/authorize.json -H X-Auth-User:$X_AUTH_USER -H X-Auth-Key:$X_AUTH_KEY | jq -r '.auth_token')
echo "Your key is : $MYKEY"$'\n'

# Get domain records
echo "Getting $DOMAIN records..."$'\n'
JSON=$(curl -s http://dozens.jp/api/record/$ZONE.json -H X-Auth-Token:$MYKEY)

# Search acme-challenge txt record id
echo "Serching $DOMAIN acme-challenge TXT record..."
RECORDID=$(echo "$JSON" | jq -r ".record[] | select(.name == \"$DOMAIN\") | select(.type == \"TXT\") | .id")
if [ -n "$RECORDID" ]; then
  echo "$DOMAIN TXT record id is $RECORDID""."$'\n'

  # Update record
  echo "Recode update in progress..."
  RESULT=$(curl -s -d "{\"prio\":\"\", \"content\":\"$CERTBOT_VALIDATION\", \"ttl\":\"7200\"}" http://dozens.jp/api/record/update/$RECORDID.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json" | jq -r ".record[] | select(.id == \"$RECORDID\")")
  echo "Dozens server says : $RESULT"$'\n'
else
  echo "$DOMAIN TXT record does not exist."$'\n'

  # Add record
  echo "Recode add in progress..."
  NAME=$(echo "$DOMAIN" | sed -e "s/\.$ZONE$//")
  RESULT=$(curl -s -d "{\"domain\": \"$ZONE\", \"name\": \"$NAME\", \"type\": \"TXT\", \"prio\":\"\", \"content\":\"$CERTBOT_VALIDATION\", \"ttl\":\"7200\"}" http://dozens.jp/api/record/create.json -H X-Auth-Token:$MYKEY -H "Host: dozens.jp" -H "Content-Type:application/json" | jq -r ".record[] | select(.name == \"$DOMAIN\") | select(.type == \"TXT\")")
  echo "Dozens server says : $RESULT"$'\n'
fi

echo "Script is done!"$'\n'
