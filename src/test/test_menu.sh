#!/bin/bash

echo "Test 1: Menu List Test"
echo "=========================================="

BASE_URL="http://localhost:8081"

echo "Testing menu list endpoint..."
RESPONSE=$(curl -s "$BASE_URL/menu")

if echo "$RESPONSE" | grep -q "Menu List"; then
    echo "✓ PASSED: Menu list is accessible"
    echo "Response:"
    echo "$RESPONSE"
    exit 0
else
    echo "✗ FAILED: Menu list not accessible"
    echo "Response:"
    echo "$RESPONSE"
    exit 1
fi