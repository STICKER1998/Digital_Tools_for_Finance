import pandas as pd
from connect import DATAPATH

def get_subdataset(dataset, start_dt, end_dt):
  filename = DATAPATH + "/" + dataset
  data = pd.read_feather(filename)
  start = pd.Timestamp(start_dt)
  end = pd.Timestamp(end_dt)
  data = data[(data.iloc[:,0] >= start) & (data.iloc[:,0] <= end)]
  return data

# print(get_subdataset(dataset = "r_data.ftr", start_dt="2015-01-06", end_dt="2016-01-06"))