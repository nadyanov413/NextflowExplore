#!/bin/bash -ue
echo "File: numbers.txt" > countLinesFile.txt
wc -l < numbers.txt >> countLinesFile.txt
