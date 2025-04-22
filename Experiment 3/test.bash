#!/bin/bash

for dir in "Experiment "*/; do
    if [ -f "${dir}test.bash" ]; then
        echo "Running test.bash in $dir"
        (cd "$dir" && bash test.bash)
    else
        echo "test.bash not found in $dir"
    fi
    eval printf '=%.0s' {1..$(tput cols)}
done