#! /bin/bash
# file: examples/equality_test.sh

testEquality() {
  
  assertEquals 1 1
}

echo "Running initial test check:"

# Load and run shUnit2.
. ./test/libs/shunit2/shunit2
