import pandas as pd
import numpy as np
from downstream import get_subdataset
def Read_Data(FILEPATH,dataset,start_dt,end_dt):
    """
        Read and Modify the raw data

        Parameters
        ----------
        FILEPATH: The path of the file
        dataset: The path of the data
        start_dt,end_dt: The range of the time dor the data
        Returns
        -------
         r: np.array
            d * n the daily returns of assets
         month_index:np.array
            19 * 1 store the index for changing the weight of each assets
    """
    data=get_subdataset(FILEPATH,dataset,start_dt, end_dt)
    data = data.values
    date = data[1:, 0]
    Price = np.array(data[:, 1:]).T
    r = (Price[:, 1:] - Price[:, 0:-1]) / Price[:, 0:-1]
    r = r.astype(float)
    month_index = [0]
    for i in range(len(date) - 1):
        if (date[i].month != date[i + 1].month):
            month_index.append(i + 1)
    month_index.append(np.size(r, 1))  # the first day of 2020
    return r, date, month_index

def Write_Data(FILEPATH,w_std,w_VaR,w_ES,values_std,values_VaR,values_ES,date,month_index):
    data1 = {"Time": date[month_index[3] - 1:], "value_std": values_std.T[0], "value_VaR": values_VaR.T[0],
             "value_ES": values_ES.T[0]}
    data1 = pd.DataFrame(data1)
    data1.to_excel(FILEPATH + "\\data\\result\\python\\Values.xlsx")

    data2 = {"Time": date[month_index[3]:], "w_std_stock": w_std[0, :], "w_VaR_stock": w_VaR[0, :],
             "w_ES_stock": w_ES[0, :]}
    data2 = pd.DataFrame(data2)
    data2.to_excel(FILEPATH + "\\data\\result\\python\\weight_stock.xlsx")

    data3 = {"Time": date[month_index[3]:], "w_std_stock": w_std[0, :], "w_VaR_stock": w_VaR[0, :],
             "w_ES_stock": w_ES[0, :]}
    data3 = pd.DataFrame(data3)
    data3.to_excel(FILEPATH + "\\data\\result\\python\\weight_bond.xlsx")

    data4 = {"Time": date[month_index[3]:], "w_std_stock": w_std[0, :], "w_VaR_stock": w_VaR[0, :],
             "w_ES_stock": w_ES[0, :]}
    data4 = pd.DataFrame(data4)
    data4.to_excel(FILEPATH + "\\data\\result\\python\\weight_gold.xlsx")