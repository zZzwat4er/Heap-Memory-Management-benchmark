#include <chrono>
#include <string>
#include <iostream>
#include <algorithm>

int main(int argc, char *argv[]) {
    int size = std::stoi(argv[1]);
    int loops = 1000;
    // warm up the program
    for (int i = 0; i < loops; i++) {
        int* array = new int[size];
        for (int j = 0; j < size; j++) {
            array[j] = j;
        }
        delete[] array;
    }

    std::chrono::duration<long int, std::ratio<1, 1000000000>>* creationTimes = new std::chrono::duration<long int, std::ratio<1, 1000000000>>[loops];
    auto executionTimeStart = std::chrono::high_resolution_clock::now();

    for (int i = 0; i < loops; i++) {
        auto creationTime = std::chrono::high_resolution_clock::now();
        int* array = new int[size];
        for (int j = 0; j < size; j++) {
            array[j] = j;
        }
        creationTimes[i] = std::chrono::high_resolution_clock::now() - creationTime;
        delete[] array;
    }

    auto executionTime = std::chrono::high_resolution_clock::now() - executionTimeStart;
    std::sort(creationTimes, creationTimes + loops);
    std::chrono::duration<long int, std::ratio<1, 1000000000>> meanCT = creationTimes[loops / 2];

    std::cout << "Median loop time " << meanCT.count() << "ns" << std::endl;
    std::cout << "Execution time " << std::chrono::duration_cast<std::chrono::milliseconds>(executionTime).count() << "ms" << std::endl;
    return 0;
}
