#!/bin/bash -ue
echo "Greetings:" > null
for name in ; do
    echo "Hello: $name" >> null
done
