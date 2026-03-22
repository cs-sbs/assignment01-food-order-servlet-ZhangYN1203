#!/bin/bash

echo "Running all tests for Servlet Order System..."

BASE_URL="http://localhost:8080"
PASSED=0
FAILED=0

echo "=========================================="
echo "Test 1: Check Menu List"
echo "=========================================="
RESPONSE=$(curl -s "$BASE_URL/menu")
if echo "$RESPONSE" | grep -q "Menu List"; then
    echo "✓ Test 1 PASSED: Menu list accessible"
    ((PASSED++))
else
    echo "✗ Test 1 FAILED: Menu list not accessible"
    ((FAILED++))
fi

echo ""
echo "=========================================="
echo "Test 2: Create Order"
echo "=========================================="
CREATE_RESPONSE=$(curl -s -X POST -d "customer=Alice&food=Fried Rice&quantity=2" "$BASE_URL/order")
ORDER_ID=$(echo "$CREATE_RESPONSE" | grep -oP 'Order Created: \K\d+')
if [ -n "$ORDER_ID" ]; then
    echo "✓ Test 2 PASSED: Order created with ID $ORDER_ID"
    ((PASSED++))
else
    echo "✗ Test 2 FAILED: Order creation failed"
    echo "Response: $CREATE_RESPONSE"
    ((FAILED++))
fi

echo ""
echo "=========================================="
echo "Test 3: Query Order Detail"
echo "=========================================="
if [ -n "$ORDER_ID" ]; then
    DETAIL_RESPONSE=$(curl -s "$BASE_URL/order/$ORDER_ID")
    if echo "$DETAIL_RESPONSE" | grep -q "Order Detail" && echo "$DETAIL_RESPONSE" | grep -q "Order ID: $ORDER_ID"; then
        echo "✓ Test 3 PASSED: Order detail retrieved"
        ((PASSED++))
    else
        echo "✗ Test 3 FAILED: Order detail not retrieved"
        echo "Response: $DETAIL_RESPONSE"
        ((FAILED++))
    fi
else
    echo "✗ Test 3 SKIPPED: No order ID available"
fi

echo ""
echo "=========================================="
echo "Test 4: Menu Search"
echo "=========================================="
SEARCH_RESPONSE=$(curl -s "$BASE_URL/menu?name=Fried")
if echo "$SEARCH_RESPONSE" | grep -q "Fried Rice" && echo "$SEARCH_RESPONSE" | grep -q "Fried Noodles"; then
    echo "✓ Test 4 PASSED: Menu search works"
    ((PASSED++))
else
    echo "✗ Test 4 FAILED: Menu search failed"
    echo "Response: $SEARCH_RESPONSE"
    ((FAILED++))
fi

echo ""
echo "=========================================="
echo "Test Summary"
echo "=========================================="
echo "Total Tests: $((PASSED + FAILED))"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Success Rate: $(( PASSED * 100 / (PASSED + FAILED) ))%"

if [ $FAILED -eq 0 ]; then
    echo "✓ All tests passed!"
    exit 0
else
    echo "✗ Some tests failed"
    exit 1
fi