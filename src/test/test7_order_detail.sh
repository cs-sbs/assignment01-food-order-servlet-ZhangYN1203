#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

# create order
curl -s -X POST $BASE_URL/order \
  -d "customer=Bob" \
  -d "food=Burger" \
  -d "quantity=1" > /dev/null

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" $BASE_URL/order/1001)
body="$(cat "$tmp")"
rm -f "$tmp"

if [[ "$status" == "200" ]] && [[ "$body" == *"Order"* ]]; then
  echo "PASS: order detail works"
  exit 0
else
  echo "FAIL: order detail not working"
  exit 1
fi
