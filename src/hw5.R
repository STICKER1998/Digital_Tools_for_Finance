set.seed(1)
n <- 1e6 
A <- rnorm(n)
B <- rnorm(n)
C <- rnorm(n)
D <- rnorm(n)
E <- A
df <- data.frame("A" = A, "B" = B, "C" = C, "D" = D, "E" = E)


# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("rhdf5")

library(rhdf5)
start <- Sys.time()
h5write(df, "df.h5","df")
end <- Sys.time()
t_HDF <- end - start

# install.packages("arrow")
library(arrow)
start <- Sys.time()
write_feather(df, "df.feather")
end <- Sys.time()
t_Feather <- end - start

start <- Sys.time()
write_feather(df, "df.parquet")
end <- Sys.time()
t_Parquet <- end - start

df_t <- data.frame("HDF Time" = t_HDF,
                   "Feather Time" = t_Feather,
                   "Parquet Time" = t_Parquet)
write.table(df_t, file = "time.txt")
