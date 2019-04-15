#!/bin/bash

octave run_example1.m > computed_results.txt
octave run_tables.m >> computed_results.txt

echo "CHECKING DIFFERENCES BETWEEN EXPECTED AND COMPUTED"
python check_results.py expected_results.txt computed_results.txt
