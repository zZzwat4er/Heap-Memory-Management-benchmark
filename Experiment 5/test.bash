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

output_file="./output/output.txt"
max_test_size=50000
> $output_file

echo "Running the test"
echo "Running C++ program"
echo "C++ Program Output:" >> $output_file
$cpp_bin >> $output_file
if [ $? -ne 0 ]; then
    echo "C++ program failed"
    exit 1
fi
echo "" >> $output_file
echo "Running Java program"
echo "Java Program Output:" >> $output_file
java -cp ./output $java_bin >> $output_file
if [ $? -ne 0 ]; then
    echo "Java program failed"
    exit 1
fi

echo "Generating plot from test results"
python plt.py

echo "All operations completed."
echo "Check $output_file for results."
echo "Check plot.png for graph."
