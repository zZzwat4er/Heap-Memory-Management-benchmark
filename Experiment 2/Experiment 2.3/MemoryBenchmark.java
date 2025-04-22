public class MemoryBenchmark {
    public static void main(String[] args){
        Integer size = 5000;
        Integer loops = 200000;
        long[] creationTimes = new long[loops];

        for (int i = 0; i < loops; i++){
            long creationTime = System.nanoTime();
            int[] array = new int[size];
            for (int j = 0; j < size; j++){
                array[j] = j;
            }
            creationTimes[i] = System.nanoTime() - creationTime;
        }
        
        StringBuilder output = new StringBuilder(loops * 6); // Pre-allocate buffer
        for (int i = 0; i < loops; i++) {
            output.append(creationTimes[i]).append(' ');
        }
        System.out.println(output);
    }
}