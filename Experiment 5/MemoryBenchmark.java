public class MemoryBenchmark {
    static int[][] createMatrix(int size) {
        int[][] matrix = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                matrix[i][j] = 1;
            }
        }
        return matrix;
    }

    static int[][] transformMatrix(int[][] input) {
        int size = input.length;
        int[][] result = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                result[i][j] = input[j][i];  // Transpose
                if (i == j) {
                    // Temporary matrix allocation (5x5 matrix of 1s)
                    int[][] temp = createMatrix(5);
                    result[i][j] += temp[0][0];
                }
            }
        }
        return result;
    }

    public static void main(String[] args) {
        final int ITERATIONS = 5000;
        final int MAX_SIZE = 1000;
        long[] iterationTime = new long[ITERATIONS];
        // Warm up
        for (int i = 0; i < 100; i++) {
            createMatrix(1000);
        }
        System.gc();
        
        for (int i = 0; i < ITERATIONS; i++) {
            int size = (i % (MAX_SIZE / 50)) * 50;
            long transformTime = System.nanoTime();
            int[][] original = createMatrix(size);
            int[][] transformed = transformMatrix(original);
            iterationTime[i] = System.nanoTime() - transformTime;
            
            // if (i % 100 == 0) {
            //     System.gc();  // Periodic garbage collection
            // }
        }
        

        StringBuilder output = new StringBuilder(ITERATIONS * 6); // Pre-allocate buffer
        for (int i = 0; i < ITERATIONS; i++) {
            output.append(iterationTime[i]).append(' ');
        }
        System.out.println(output);
    }
}