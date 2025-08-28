#!/bin/bash -ue
echo "Greetings:" > greetFile.txt
for name in ; do
    echo "Hello: $name" >> greetFile.txt
done
