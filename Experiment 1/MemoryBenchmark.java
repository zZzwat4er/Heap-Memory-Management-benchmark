public class MemoryBenchmark {
    public static void main(String[] args){
        Integer size = Integer.parseInt(args[0]);
        Integer loops = 1000;
        long[] creationTimes = new long[loops];
        long executionTimeStart = System.currentTimeMillis();

        for (int i = 0; i < loops; i++){
            creationTimes[i] = System.nanoTime();
            int[] array = new int[size];
            for (int j = 0; j < size; j++){
                array[j] = j;
            }
            creationTimes[i] = System.nanoTime() - creationTimes[i];
        }

        long executionTime = System.currentTimeMillis() - executionTimeStart;

        // sort the creation times to calculate the mean
        for (int i = 0; i < loops - 1; i++){
            for (int j = 0; j < loops - i - 1; j++){
                if (creationTimes[j] > creationTimes[j + 1]){
                    long temp = creationTimes[j];
                    creationTimes[j] = creationTimes[j + 1];
                    creationTimes[j + 1] = temp;
                }
            }
        }
        // get the mean creation time 
        long meanCT = creationTimes[loops / 2];
        
        System.out.println("Median loop time " + meanCT + "ns");
        System.out.println("Execution time " + executionTime + "ms");
    }
}