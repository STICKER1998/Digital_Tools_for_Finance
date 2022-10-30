# Exercise 5
## Problem 
1. in your favorite language, create a non-empty dataframe with 1e06 rows and 5 columns, making two of the columns completely identical;
2. dump it to a file in `homework5/` using HDF, Feather and Parquet format, recording the amount of time required for this, and save the three times to a .txt file in the same folder;
3. using `git lfs` start tracking the Feather file you created above, commit it and push to GitHub;

## Solution
1. Create a script `hw5.R` to create a data frame with 1e6 rows and 5 columns, two of which are exactly the same.
2. Save it as a file in `HDF`, `Feather`, `Parquet` format, and record the time of saving the data to `homework5/time.txt`;
3. Because the data is too large, use `git lfs` to solve the problem of uploading directly to git;
