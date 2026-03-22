#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" -X POST $BASE_URL/order \
  -d "customer=Alice" \
  -d "food=Burger" \
  -d "quantity=abc")
body="$(cat "$tmp")"
rm -f "$tmp"

if { [[ "$status" == "200" ]] || [[ "$status" == "400" ]]; } \
   && { [[ "$body" == *"Error"* ]] || [[ "$body" == *"invalid"* ]]; } \
   && [[ "$status" != "404" ]]; then
  echo "PASS: invalid quantity handled"
  exit 0
else
  echo "FAIL: invalid quantity not handled"
  exit 1
fi
