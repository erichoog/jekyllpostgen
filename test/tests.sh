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
    
    ## Source the script to access config variables
    . ../../jekyllpostgen.sh "$TITLE" > /dev/null

    EXPECTED_FILENAME="$(date +%F)-your-test-shunit2-title.$file_extension"

    if [ ! -f "$EXPECTED_FILENAME" ]; then
      fail "ERROR: Expected file $EXPECTED_FILENAME was not found." 
    fi
  )
}

# Load and run shUnit2.
. ./test/libs/shunit2/shunit2
