#include <iostream>
#include <chrono>
#include <vector>
#include <new>
#include <cstdlib>
#include <sys/resource.h>
#include <unistd.h>
#include <ctime>

int main(int argc, char *argv[]) {
    auto start = std::chrono::high_resolution_clock::now();
    int size = std::stoi(argv[1]);
    struct rusage startUsage;
    getrusage(RUSAGE_SELF, &startUsage);
    auto startCpuTime = std::clock();

    // Run the benchmark
    for (int i = 0; i < size; i++) {
        int* array = new int[size * 100];
        for (int j = 0; j < size * 100; j++) {
            array[j] = j;
        }
        delete[] array;
    }

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();

    struct rusage endUsage;
    getrusage(RUSAGE_SELF, &endUsage);
    auto endCpuTime = std::clock();

    long peakMemoryUsage = endUsage.ru_maxrss;
    long cpuUsage = endCpuTime - startCpuTime;

    // Print results
    std::cout << "Peak Memory Usage: " << peakMemoryUsage << " kilobytes" << std::endl;
    std::cout << "CPU Usage: " << 1000.0 * cpuUsage / CLOCKS_PER_SEC << " ms" << std::endl;
    std::cout << "Benchmark Duration: " << duration << " ms" << std::endl;

    return 0;
}
