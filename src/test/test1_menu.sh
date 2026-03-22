#!/bin/bash

set -euo pipefail
BASE_URL="http://localhost:8080"

tmp="$(mktemp)"
status=$(curl -s -o "$tmp" -w "%{http_code}" "$BASE_URL/menu")
body="$(cat "$tmp")"
rm -f "$tmp"

if [[ "$status" == "200" ]] && [[ "$body" == *"Menu"* ]]; then
  echo "PASS: menu endpoint exists"
  exit 0
else
  echo "FAIL: menu endpoint not working"
  exit 1
fi
