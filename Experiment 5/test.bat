@echo off
setlocal enabledelayedexpansion

REM Change to script directory
cd /d "%~dp0"

REM Set file and binary paths
set "cpp_file=MemoryBenchmark.cpp"
set "java_file=MemoryBenchmark.java"
set "cpp_bin=output\MemoryBenchmark.exe"
set "java_bin=MemoryBenchmark"

REM Create output directories if they don't exist
if not exist "output" mkdir output
if not exist "fig" mkdir fig

REM Compile C++ program
g++ %cpp_file% -o %cpp_bin%
if errorlevel 1 (
    echo Failed to compile C++
    exit /b 1
)

REM Compile Java program
javac %java_file% -d output
if errorlevel 1 (
    echo Failed to compile Java
    exit /b 1
)

set "output_file=output\output.txt"
set "max_test_size=50000"
type nul > "%output_file%"

echo Running the test
echo Running C++ program
echo C++ Program Output: >> "%output_file%"
%cpp_bin% >> "%output_file%"
if errorlevel 1 (
    echo C++ program failed
    exit /b 1
)
echo. >> "%output_file%"
echo Running Java program
echo Java Program Output: >> "%output_file%"
java -cp ./output %java_bin% >> "%output_file%"
if errorlevel 1 (
    echo Java program failed
    exit /b 1
)

echo Generating plot from test results
py plt.py

echo All operations completed.
echo Check %output_file% for results.
echo Check plot.png for graph.

endlocal