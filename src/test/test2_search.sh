#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" "$BASE_URL/menu?name=Fried")
body="$(cat "$tmp")"
rm -f "$tmp"

if [[ "$status" == "200" ]] && [[ "$body" == *"Fried"* ]]; then
  echo "PASS: search works"
  exit 0
else
  echo "FAIL: search failed"
  exit 1
fi
