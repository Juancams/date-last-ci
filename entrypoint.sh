#!/usr/bin/env bash

COLOR=$1
SHOW_YEAR=$2
SHOW_MONTH=$3
SHOW_DAY=$4
SHOW_DAY=$5
GIST_ID=$6
GIST_TOKEN=$7
GIST_FILENAME=$8

DATE_STRING=""

if [ "$SHOW_YEAR" == "true" ]; then
  DATE_STRING+=$(date -u +"%Y")
fi

if [ "$SHOW_MONTH" == "true" ]; then
  if [ -n "$DATE_STRING" ]; then
    DATE_STRING+="%20"
  fi
  DATE_STRING+=$(date -u +"%b")
fi

if [ "$SHOW_DAY" == "true" ]; then
  if [ -n "$DATE_STRING" ]; then
    DATE_STRING+="%20"
  fi
  DATE_STRING+=$(date -u +"%d")
fi

if [ "$SHOW_HOUR" == "true" ]; then
  if [ -n "$DATE_STRING" ]; then
    DATE_STRING+="%20"
  fi
  DATE_STRING+=$(date -u +"%r")
fi

BADGE_STRING="![distro](https://img.shields.io/badge/Last%20CI-$DATE_STRING-$COLOR)"

JSON_PAYLOAD=$(jq -n \
  --arg filename "$GIST_FILENAME" \
  --arg content "$BADGE_STRING" \
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