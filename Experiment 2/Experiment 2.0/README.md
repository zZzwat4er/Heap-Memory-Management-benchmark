# Memory Management Performance Experiment: Java vs. C++

## Experiment Overview
This experiment compares memory management performance between Java and C++ by measuring:
1. Execution time for creating and deleting integer arrays
2. Median time per array creation
3. Performance across different array sizes

## Experiment Design
- **Test Case**: Creation and deletion of integer arrays
- **Array Sizes**: Varied from 1000 to 50000 elements
- **Iterations**: 1000 iterations per array size
- **Metrics Collected**:
  - Total execution time
  - Median time per create/delete operation

## Results
![Execution Time](./fig/ExecutionTime.png)
*Fig 1: Total execution time comparison for 1000 array operations*

![Median Time](./fig/AverageMedian.png)
*Fig 2: Median time per array create/delete operation*

### Key Findings
1. **Execution Time**:
   - Java performance became competitive at array sizes above [20000] elements
   - C++ shows a consistent linear grow of execution time based on array size
   - Java execution time shows inconsistencies with large array sizes 

2. **Median Create/Delete Time**:
   - Shows consistent linear grow of execution time for both C++ and Java
   - C++ shows rapid rate of grow of memory management compared to java

## How to Reproduce
### Java Implementation
```bash
cd java/
javac ArrayBenchmark.java
java ArrayBenchmark