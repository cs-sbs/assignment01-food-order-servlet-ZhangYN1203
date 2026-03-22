#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" -X POST $BASE_URL/order \
  -d "customer=Alice" \
  -d "food=Fried Rice" \
  -d "quantity=2")
body="$(cat "$tmp")"
rm -f "$tmp"

if [[ "$status" == "200" ]] && [[ "$body" == *"Order"* ]]; then
  echo "PASS: order created"
  exit 0
else
  echo "FAIL: order creation failed"
  exit 1
fi
