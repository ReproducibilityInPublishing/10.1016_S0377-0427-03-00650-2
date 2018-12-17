#!/bin/bash

./computation.sh

echo "CHECKING DIFFERENCES BETWEEN EXPECTED AND COMPUTED"
python check_results.py expected_results.txt computed_results.txt
