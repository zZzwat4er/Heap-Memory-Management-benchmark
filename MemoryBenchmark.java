import java.lang.management.*;
import java.util.List;

public class MemoryBenchmark {
    public static void main(String[] args) throws Exception {
        MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
        List<GarbageCollectorMXBean> gcBeans = ManagementFactory.getGarbageCollectorMXBeans();

        long startTime = System.currentTimeMillis();
        long startCpuTime = getCpuTime();

        int size = Integer.parseInt(args[0]);

        // Run the benchmark
        for (int i = 0; i < size; i++) {
            createDummyObjects(size);
        }

        long endTime = System.currentTimeMillis();
        long endCpuTime = getCpuTime();

        // Collect metrics
        MemoryUsage heapUsage = memoryMXBean.getHeapMemoryUsage();
        long gcTime = getTotalGCTime(gcBeans);
        long peakMemoryUsage = heapUsage.getCommitted();
        long cpuUsage = endCpuTime - startCpuTime;
        long duration = endTime - startTime;

        // Print results
        System.out.println("Peak Memory Usage: " + peakMemoryUsage / 1000 + " kilobytes");
        System.out.println("GC Time: " + gcTime + " ms");
        System.out.println("CPU Usage: " + cpuUsage / 1e6 + " ms");
        System.out.println("Benchmark Duration: " + duration + " ms");
    }

    private static void createDummyObjects(int size) {
        int[] array = new int[size * 100];
        for (int i = 0; i < array.length; i++) {
            array[i] = i;
        }
    }

    private static long getTotalGCTime(List<GarbageCollectorMXBean> gcBeans) {
        long gcTime = 0;
        for (GarbageCollectorMXBean gcBean : gcBeans) {
            gcTime += gcBean.getCollectionTime();
        }
        return gcTime;
    }

    private static long getTotalAllocations(List<GarbageCollectorMXBean> gcBeans) {
        long allocations = 0;
        for (GarbageCollectorMXBean gcBean : gcBeans) {
            allocations += gcBean.getCollectionCount();
        }
        return allocations;
    }

    private static long getCpuTime() {
        ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
        return threadMXBean.getCurrentThreadCpuTime();
    }
}
