#! /bin/bash

initializeTest() {
    cd ./test    
    if [ ! -d tmp_test ]; then
      mkdir tmp_test
    fi
    cd tmp_test
}

test_initial_check() {
  assertEquals 1 1
}

test_filename_format() {
  (
    initializeTest

    TITLE="Your Test SHUNIT2 Title"
    EXPECTED_FILENAME="$(date +%F)-your-test-shunit2-title.md"

    RESULT=$(../../jekyllpostgen.sh "$TITLE")

    if [ ! -f "$EXPECTED_FILENAME" ]; then
      fail "ERROR: test file not found...aborting test" 
    fi
  )
}

# Load and run shUnit2.
. ./test/libs/shunit2/shunit2
