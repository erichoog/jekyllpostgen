#! /bin/bash

./test/tests.sh

cleanup() {
    rm -rf ./test/tmp_test
}
trap cleanup EXIT
