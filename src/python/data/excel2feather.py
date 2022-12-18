import pandas as pd
df = pd.read_excel("Original_Closing_Price.xlsx")
df.to_feather("Original_Closing_Price.ftr")