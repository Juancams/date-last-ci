#!/usr/bin/env bash

COLOR=$1
SHOW_YEAR=$2
SHOW_MONTH=$3
SHOW_DAY=$4
SHOW_HOUR=$5
GIST_ID=$6
GIST_TOKEN=$7
GIST_FILENAME=$8

DATE_STRING=""

if [ "$SHOW_YEAR" == "true" ]; then
  DATE_STRING+=$(date -u +"%Y")
fi

if [ "$SHOW_MONTH" == "true" ]; then
  if [ -n "$DATE_STRING" ]; then
    DATE_STRING+=" "
  fi
  DATE_STRING+=$(date -u +"%b")
fi

if [ "$SHOW_DAY" == "true" ]; then
  if [ -n "$DATE_STRING" ]; then
    DATE_STRING+=" "
  fi
  DATE_STRING+=$(date -u +"%d")
fi

if [ "$SHOW_HOUR" == "true" ]; then
  if [ -n "$DATE_STRING" ]; then
    DATE_STRING+=" "
  fi
  DATE_STRING+=$(date -u +"%r %Z")
fi

JSON_CONTENT=$(jq -n \
  --arg label "Last CI" \
  --arg message "$DATE_STRING" \
  --arg color "$COLOR" \
  '{
    "schemaVersion": 1,
    "label": $label,
    "message": $message,
    "color": $color
  }')

JSON_PAYLOAD=$(jq -n \
  --arg filename "$GIST_FILENAME" \
  --arg content "$JSON_CONTENT" \
  '{
    "files": {
      ($filename): {
        "content": $content
      }
    }
  }')

curl -X PATCH "https://api.github.com/gists/$GIST_ID" \
  -H "Authorization: token $GIST_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD"