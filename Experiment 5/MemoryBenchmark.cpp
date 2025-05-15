#include <iostream>
#include <vector>
#include <chrono>
#include <memory>
#include <string>
#include <algorithm>

using Matrix = std::vector<std::vector<int>>;

Matrix createMatrix(int size) {
    Matrix matrix(size, std::vector<int>(size));
    for (auto& row : matrix) {
        for (auto& elem : row) {
            elem = 1;
        }
    }
    return matrix;
}

Matrix transformMatrix(const Matrix& input) {
    int size = input.size();
    Matrix result(size, std::vector<int>(size));
    
    // Memory-intensive transformation
    for (int i = 0; i < size; ++i) {
        for (int j = 0; j < size; ++j) {
            result[i][j] = input[j][i];  // Transpose
            if (i == j) {
                // Create temporary matrix for diagonal operation
                auto temp = createMatrix(5);  // Small allocation
                result[i][j] += temp[0][0];
            }
        }
    }
    return result;
}

int main(int argc, char *argv[]) {
    const int ITERATIONS = 5000;
    const int MAX_SIZE = 1000;
    
    std::chrono::duration<long int, std::ratio<1, 1000000000>>* iterationTime = new std::chrono::duration<long int, std::ratio<1, 1000000000>>[ITERATIONS];

    std::vector<Matrix> matrices;
    matrices.reserve(ITERATIONS * 2);

    // Warm up
    for (int i = 0; i < 100; i++) {
        createMatrix(1000);
    }
    
    for (int i = 0; i < ITERATIONS; ++i) {
        int size = (i % (MAX_SIZE / 50)) * 50;
        auto transformTime = std::chrono::high_resolution_clock::now();
        auto original = createMatrix(size);
        auto transformed = transformMatrix(original);
        iterationTime[i] = std::chrono::high_resolution_clock::now() - transformTime;
        
        matrices.push_back(std::move(original));
        matrices.push_back(std::move(transformed));
        if (i % 100 == 0) {
            matrices.clear();  // Periodic deallocation
        }
    }
    
    std::ios_base::sync_with_stdio(false);
    std::cout.tie(nullptr);

    std::string output;
    output.reserve(ITERATIONS * 6);

    for(int i = 0; i < ITERATIONS; i++) {
        output.append(std::to_string(iterationTime[i].count()) += ' ');
    }

    // Single output operation
    std::cout << output << '\n';  // Use '\n' instead of std::endl to avoid flush
    return 0;
}