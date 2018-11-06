#!/bin/bash

octave example1.m > computed_results.txt
octave tables.m >> computed_results.txt

echo "CHECKING DIFFERENCES BETWEEN EXPECTED AND COMPUTED"
diff results.txt computed_results.txt
