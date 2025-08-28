#!/bin/bash -ue
echo "Squaring numbers..." > squareFile.txt
for n in 1 2 3 4; do
echo "Square of $n is $((n * n))" >> squareFile.txt
done
