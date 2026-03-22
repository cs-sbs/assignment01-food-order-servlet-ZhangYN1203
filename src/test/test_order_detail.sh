#!/bin/bash

echo "Test 3: Order Detail Test"
echo "=========================================="

BASE_URL="http://localhost:8081"

if [ -z "$1" ]; then
    echo "Usage: $0 <order_id>"
    echo "Example: $0 1001"
    exit 1
fi

ORDER_ID=$1

echo "Testing order detail endpoint for order ID: $ORDER_ID..."
RESPONSE=$(curl -s "$BASE_URL/order/$ORDER_ID")

if echo "$RESPONSE" | grep -q "Order Detail" && echo "$RESPONSE" | grep -q "Order ID: $ORDER_ID"; then
    echo "✓ PASSED: Order detail retrieved successfully"
    echo "Response:"
    echo "$RESPONSE"
    exit 0
else
    echo "✗ FAILED: Order detail not found"
    echo "Response:"
    echo "$RESPONSE"
    exit 1
fi