import os
import sys

FILEPATH=os.path.abspath(os.path.join(os.getcwd(), "../.."))
sys.path.append(FILEPATH+"\src\python_codes\data")
from MakeData import Read_Data,Write_Data
sys.path.append(FILEPATH+"\src\python_codes\model")
from Risk_Parity import Risk_Parity_Model

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    [r, date, month_index] = Read_Data(FILEPATH,dataset="Original_Closing_Price.ftr", start_dt="2015-01-05", end_dt="2019-12-30")
    print("Model based on std Start:")
    [w_std, values_std,w1] = Risk_Parity_Model(r, 'std', month_index)
    print("Model based on VaR Start:")
    [w_VaR,values_VaR,w2]=Risk_Parity_Model(r,'VaR',month_index)
    print("Model based on ES Start:")
    [w_ES,values_ES,w3]=Risk_Parity_Model(r,'ES',month_index)
    Write_Data(FILEPATH,w_std,w_VaR,w_ES,values_std,values_VaR,values_ES,date,month_index)
    print("All Finished!")