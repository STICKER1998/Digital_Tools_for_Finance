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
    data1 = {"value_std": values_std.T[0], "value_VaR": values_VaR.T[0], "value_ES": values_ES.T[0]}
    data1 = pd.DataFrame(data1)
    data1.to_excel(FILEPATH+"\\data\\result\\Net_Value.xlsx")

    data2 = {"w_std_stock": w_std[0, :], "w_std_bond": w_std[1, :], "w_std_gold": w_std[2, :]}
    data2 = pd.DataFrame(data2)
    data2.to_excel(FILEPATH+"\\data\\result\\Weight_std.xlsx")

    data3 = {"w_std_stock": w_VaR[0, :], "w_std_bond": w_VaR[1, :], "w_std_gold": w_VaR[2, :]}
    data3 = pd.DataFrame(data3)
    data3.to_excel(FILEPATH+"\\data\\result\\Weight_VaR.xlsx")

    data4 = {"w_std_stock": w_ES[0, :], "w_std_bond": w_ES[1, :], "w_std_gold": w_ES[2, :]}
    data4 = pd.DataFrame(data4)
    data4.to_excel(FILEPATH+"\\data\\result\\Weight_ES.xlsx")

    data5 = {"Time": date[month_index[3] - 1:]}
    data5 = pd.DataFrame(data5)
    data5.to_excel(FILEPATH+"\\data\\result\\Time.xlsx")