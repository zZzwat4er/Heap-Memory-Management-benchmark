import re
import pandas as pd
import matplotlib.pyplot as plt

# Read the file
with open("./output/output.txt", "r") as file:
    data = file.read()

# Regex pattern to extract the data
pattern = re.compile(
    r"C\+\+ Program Output:((?:\s+\d+)+).*?"
    r"Java Program Output:((?:\s+\d+)+)",
    re.DOTALL,
)

# Find matches
matches = pattern.findall(data)

# Process matches into separate number lists
cpp_numbers = matches[0][0].split()
java_numbers = matches[0][1].split()

# Create DataFrame
df = pd.DataFrame({
    "C++ Loop Execution time (ns)": cpp_numbers,
    "Java Loop Execution time (ns)": java_numbers
}).apply(pd.to_numeric)
df.to_csv('./output/out.csv', index=False)

# Plot the data
plt.figure(figsize=(21, 9))
plt.plot(range(len(df["C++ Loop Execution time (ns)"])), df["C++ Loop Execution time (ns)"], label="C++", linestyle="-")
plt.plot(range(len(df["Java Loop Execution time (ns)"])), df["Java Loop Execution time (ns)"], label="Java", linestyle="-")
plt.title("Median loop time / Array Size")
plt.xlabel("Loop")
plt.ylabel("Execution time (ns)")
plt.grid(True)
plt.legend()
plt.savefig("fig/LoopTimes.png")

window_size = 10
df_smoothed = df.rolling(window=window_size).mean().dropna()

plt.figure(figsize=(21, 9))
plt.plot(range(len(df_smoothed["C++ Loop Execution time (ns)"])), df_smoothed["C++ Loop Execution time (ns)"], label="C++", linestyle="-")
plt.plot(range(len(df_smoothed["Java Loop Execution time (ns)"])), df_smoothed["Java Loop Execution time (ns)"], label="Java", linestyle="-")
plt.title("Median loop time / Array Size")
plt.xlabel("Loop")
plt.ylabel("Execution time (ns)")
plt.grid(True)
plt.legend()
plt.savefig("fig/LoopTimesSmoothed.png")