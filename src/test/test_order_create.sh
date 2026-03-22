#!/bin/bash

echo "Test 2: Order Creation Test"
echo "=========================================="

BASE_URL="http://localhost:8081"

echo "Testing order creation endpoint..."
RESPONSE=$(curl -s -X POST -d "customer=Alice&food=Fried Rice&quantity=2" "$BASE_URL/order")

ORDER_ID=$(echo "$RESPONSE" | grep -oP 'Order Created: \K\d+')

if [ -n "$ORDER_ID" ]; then
    echo "✓ PASSED: Order created successfully"
    echo "Order ID: $ORDER_ID"
    echo "Response:"
    echo "$RESPONSE"
    exit 0
else
    echo "✗ FAILED: Order creation failed"
    echo "Response:"
    echo "$RESPONSE"
    exit 1
fi