#include <chrono>
#include <string>
#include <iostream>
#include <algorithm>

int main(int argc, char *argv[]) {
    int size = 20000;
    int loops = 200000;
    std::chrono::duration<long int, std::ratio<1, 1000000000>>* creationTimes = new std::chrono::duration<long int, std::ratio<1, 1000000000>>[loops];

    for (int i = 0; i < loops; i++) {
        auto creationTime = std::chrono::high_resolution_clock::now();
        int* array = new int[size];
        for (int j = 0; j < size; j++) {
            array[j] = j;
        }
        creationTimes[i] = std::chrono::high_resolution_clock::now() - creationTime;
        delete[] array;
    }

    std::ios_base::sync_with_stdio(false);
    std::cout.tie(nullptr);

    std::string output;
    output.reserve(loops * 6);

    for(int i = 0; i < loops; i++) {
        output.append(std::to_string(creationTimes[i].count()) += ' ');
    }

    // Single output operation
    std::cout << output << '\n';  // Use '\n' instead of std::endl to avoid flush
    return 0;
}
