#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" $BASE_URL/order/9999)
body="$(cat "$tmp")"
rm -f "$tmp"

if [[ "$status" == "404" ]] \
   || ( { [[ "$status" == "200" ]] || [[ "$status" == "400" ]]; } \
        && { [[ "$body" == *"Error"* ]] || [[ "$body" == *"not"* ]] || [[ "$body" == *"Not"* ]]; } \
        && { [[ "$body" == *"order"* ]] || [[ "$body" == *"Order"* ]]; } ); then
  echo "PASS: order not found handled"
  exit 0
else
  echo "FAIL: missing order not handled"
  exit 1
fi
