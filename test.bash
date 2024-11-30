#!/bin/bash

# Compile the C++ source file
g++ MemoryBenchmark.cpp -o MemoryBenchmark
if [ $? -ne 0 ]; then
    echo "Failed to compile C++"
    exit 1
fi

# Compile the Java source file
javac MemoryBenchmark.java
if [ $? -ne 0 ]; then
    echo "Failed to compile Java"
    exit 1
fi

# Run the compiled programs with arguments from 1000 to 100000 with step 1000
output_file="output.txt"
max_test_size=10000
> $output_file

for ((i=1000; i<=max_test_size; i+=1000))
do
    echo "Running the test with size: $i, max size: $max_test_size"
    echo "Running with argument $i" >> $output_file
    echo "C++ Program Output:" >> $output_file
    ./MemoryBenchmark $i >> $output_file
    echo "" >> $output_file
    echo "Java Program Output:" >> $output_file
    java MemoryBenchmark $i >> $output_file
    echo "----------------------" >> $output_file
    tput cuu1
    tput el
done

echo "All operations completed. Check $output_file for results."
