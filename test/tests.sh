#! /bin/bash

test_initial_check() {
  assertEquals 1 1
}

test_title_tag() {
  (
    cd ./test
    
    if [ ! -d tmp_test ]; then
      mkdir tmp_test
    fi

    cd tmp_test
    TITLE="Your Test SHUNIT2 Title"
    EXPECTED_FILENAME="$(date +%F)-your-test-shunit2-title.md"

    RESULT=$(../../jekyllpostgen.sh "$TITLE")

    # NEW_RESULT=$(sed 's/^.*.\/.*.md//' <<< "$RESULT")
    # echo $NEW_RESULT
  )
}

# Load and run shUnit2.
. ./test/libs/shunit2/shunit2
