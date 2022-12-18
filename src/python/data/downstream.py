import pandas as pd
def get_subdataset(FILEPATH,dataset, start_dt, end_dt):

  DATAPATH=FILEPATH+"\\data\\raw"
  filename = DATAPATH + "\\" + dataset
  data = pd.read_feather(filename)
  start = pd.Timestamp(start_dt)
  end = pd.Timestamp(end_dt)
  data = data[(data.iloc[:,0] >= start) & (data.iloc[:,0] <= end)]
  return data

