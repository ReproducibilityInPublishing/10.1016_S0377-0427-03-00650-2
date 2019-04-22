#!/bin/bash

octave run_tests.m > computed_results.txt

echo "CHECKING DIFFERENCES BETWEEN EXPECTED AND COMPUTED"
python2 check_results.py expected_results.txt computed_results.txt
