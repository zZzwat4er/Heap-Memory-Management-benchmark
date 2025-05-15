import re
import pandas as pd
import matplotlib.pyplot as plt

# Read the file
with open("./output/output.txt", "r") as file:
    data = file.read()

# Regex pattern to extract the data
pattern = re.compile(
    r"Running with array size (\d+).*?"
    r"C\+\+ Program Output:\s*Median loop time (\d+)ns.*?"
    r"Execution time (\d+)ms.*?"
    r"Java Program Output:\s*Median loop time (\d+)ns.*?"
    r"Execution time (\d+)ms.",
    re.DOTALL,
)

# Find all matches
matches = pattern.findall(data)
# Convert to a DataFrame
df = pd.DataFrame(matches, columns=["Array Size", "C++ Median (ns)", "C++ ExecTime (ms)", "Java Median (ns)", "Java ExecTime (ms)"])
df = df.apply(pd.to_numeric)  # Convert strings to numbers

df.to_csv('./output/out.csv', index=False)  

# Plot the data
plt.figure(figsize=(21, 9))
plt.plot(df["Array Size"], df["C++ Median (ns)"], label="C++", linestyle="-")
plt.plot(df["Array Size"], df["Java Median (ns)"], label="Java", linestyle="-")
plt.title("Median loop time / Array Size")
plt.xlabel("Array Size")
plt.ylabel("Median loop time (ns)")
plt.grid(True)
plt.legend()
plt.savefig("fig/AverageMedian.png")

plt.figure(figsize=(21, 9))
plt.plot(df["Array Size"], df["C++ ExecTime (ms)"], label="C++", linestyle="-")
plt.plot(df["Array Size"], df["Java ExecTime (ms)"], label="Java", linestyle="-")
plt.title("Execution Time / Array Size")
plt.xlabel("Array Size")
plt.ylabel("Execution Time (ms)")
plt.grid(True)
plt.legend()
plt.savefig("fig/ExecutionTime.png")