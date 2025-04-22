#!/run/current-system/sw/bin/bash

cd "$(dirname "$0")"

# aliases for source files and binaries
cpp_file="MemoryBenchmark.cpp"
java_file="MemoryBenchmark.java"
cpp_bin="./output/MemoryBenchmark"
java_bin="MemoryBenchmark"

# Make output directories if it doesn't exist
mkdir -p output
mkdir -p fig

# Compile the C++ source file
g++ $cpp_file -o $cpp_bin
if [ $? -ne 0 ]; then
    echo "Failed to compile C++"
    exit 1
fi

# Compile the Java source file
javac $java_file -d output
if [ $? -ne 0 ]; then
    echo "Failed to compile Java"
    exit 1
fi

# Run the compiled programs with arguments from 1000 to 100000 with step 1000
output_file="./output/output.txt"
max_test_size=50000
> $output_file

for ((i=1000; i<=max_test_size; i+=1000))
do
    echo "Running the test with size: ${i}, max size: ${max_test_size}"
    echo "Running with array size $i" >> $output_file
    echo "C++ Program Output:" >> $output_file
    $cpp_bin $i >> $output_file
    if [ $? -ne 0 ]; then
        echo "C++ program failed"
        exit 1
    fi
    echo "" >> $output_file
    echo "Java Program Output:" >> $output_file
    java -cp ./output $java_bin $i >> $output_file
    if [ $? -ne 0 ]; then
        echo "Java program failed"
        exit 1
    fi
    echo "----------------------" >> $output_file
    tput cuu1
    tput el
done

echo "Generating plot from test results"
python plt.py

echo "All operations completed."
echo "Check $output_file for results."
echo "Check plot.png for graph."
