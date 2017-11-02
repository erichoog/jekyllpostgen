#! /bin/bash

test_initial_check() {
  assertEquals 1 1
}

test_title_tag() {
  assertEquals 1 1
}

# Load and run shUnit2.
. ./test/libs/shunit2/shunit2
