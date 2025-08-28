#!/bin/bash -ue
echo "Greetings:" > greetFile.txt
for name in nadya olga andrey; do
    echo "Hello: $name" >> greetFile.txt
done
