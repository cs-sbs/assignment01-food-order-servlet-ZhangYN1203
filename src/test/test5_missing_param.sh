#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" -X POST $BASE_URL/order \
  -d "customer=Alice" \
  -d "food=Fried Rice")
body="$(cat "$tmp")"
rm -f "$tmp"

if { [[ "$status" == "200" ]] || [[ "$status" == "400" ]] ; } \
   && { [[ "$body" == *"Error"* ]] || [[ "$body" == *"missing"* ]]; } \
   && [[ "$status" != "404" ]]; then
  echo "PASS: missing parameter handled"
  exit 0
else
  echo "FAIL: missing parameter not handled"
  exit 1
fi
