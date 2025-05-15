@echo off
setlocal enabledelayedexpansion

REM Change to script directory
cd /d "%~dp0"

REM aliases for source files and binaries
set "cpp_file=MemoryBenchmark.cpp"
set "java_file=MemoryBenchmark.java"
set "cpp_bin=output\MemoryBenchmark.exe"
set "java_bin=MemoryBenchmark"

REM Make output directories if they don't exist
if not exist "output" mkdir output
if not exist "fig" mkdir fig

REM Compile the C++ source file
g++ %cpp_file% -o %cpp_bin%
if errorlevel 1 (
    echo Failed to compile C++
    exit /b 1
)

REM Compile the Java source file
javac %java_file% -d output
if errorlevel 1 (
    echo Failed to compile Java
    exit /b 1
)

REM Run the compiled programs with arguments from 1000 to 50000 with step 1000
set "output_file=output\output.txt"
set "max_test_size=100000"
type nul > "%output_file%"

for /l %%i in (1000, 1000, %max_test_size%) do (
    echo Running the test with size: %%i, max size: %max_test_size%
    echo Running with array size %%i >> "%output_file%"
    echo C++ Program Output: >> "%output_file%"
    %cpp_bin% %%i >> "%output_file%"
    if errorlevel 1 (
        echo C++ program failed
        exit /b 1
    )
    echo. >> "%output_file%"
    echo Java Program Output: >> "%output_file%"
    java -cp ./output %java_bin% %%i >> "%output_file%"
    if errorlevel 1 (
        echo Java program failed
        exit /b 1
    )
    echo ---------------------- >> "%output_file%"
)

echo Generating plot from test results
py plt.py

echo All operations completed.
echo Check %output_file% for results.
echo Check plot.png for graph.
endlocal