Final_Project
==============================

This is the final Project for DTFF

Data Store
---------------
    ├── data
    │   ├── raw       <- python and matlab codes would read data from this folder, the data we offered in .feather and \.xlsx form.
    │   ├── result      
    │          ├── matlab      <- The final data given by matlab codes
    │          └── python            <- The final data given by python codes
---------------
The folder `data` have two folders `raw` and `result`

## Codes and Environments
We offer two types of codes for this project: `Python` and `Matlab`, you can run all of them using your IDE and the environment setting would be given later. For `Python` code, we also offer a way to run it in `docker`, while we only offer a simple dockerfile for matlab code since you need to update some toolboxes by yourself.
### 1.Python Codes
We use the python code to implement the risk parity model in our report, while it would only give you the results of the model which include:
1. The weights of assets; (.xlsx)
2. The net value of portfolio; (.xlsx)
and all of figures in the report are drawn by MATLAB code.

All of the python codes are given in the folder `src\python`, you can run it in the ways
1. Your own IDE and install all the packages in the file [`requirements.txt`](./src/python/requirements.txt).
2. We also give you the environment export [`DTFF_Final_Project.yml`](./src/python/DTFF_Final_Project.yml), you can run it in `vscode` under `conda` environment.
3. Run it in `docker`. If you want to do this, please see the folder `docker\python`, what you need to do is
   1) Go in the folder `docker\python` using command Lines;
   2) Open the docker and run the command line:
   ```
   docker build --tag dtff-python .
   ```
   and 
   ```
   docker run -it -v "$(pwd)/data:/result" dtff-python
   ```
   3) Then you would see all of the results are shown in the folder `docker\python\data\result`.
   

### 2.Matlab Codes     
   We use the matlab codes to implement the same model as Python code and draw all of the figures in reports. In order to run the code, you only need to open the `main_function.m` in matlab -> install the toolbox `Optimization Toolbox`-> Run `main_function.m` .
   
   All of results would be exported to the folder `data\result\matlab` directly and all of the figures would be shown on your computer at the same time.


## Report and Slides

## App based on Rshiny

# Project Organization
------------

    ├── LICENSE
    ├── Makefile           <- Makefile with commands like `make data` or `make train`
    ├── README.md          <- The top-level README for developers using this project.
    ├── data
    │   ├── raw       <- python and matlab codes would read data from this folder, the data we offered in .feather and \.xlsx form.
    │   ├── result      
    │          ├── matlab      <- The final data given by matlab codes
    │          └── python            <- The final data given by python codes
    │
    ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
    │
    ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures        <- Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
    │                         generated with `pip freeze > requirements.txt`
    │
    ├── setup.py           <- makes project pip installable (pip install -e .) so src can be imported
    ├── src──                <- Source code for use in this project.
    │   ├── matlab 
    |   |   
    │   │
    │   ├── python
    |   |   └── __init__.py    <- Makes src a Python module
    |   |   |  
    |   |   ├── main.py <- The main function to run all the codes
    |   |   |
    |   |   ├── data <- Scripts to download or generate data
    │   |   |   └── MakeData.py
    |   |   |   ├── 
    |   |   |
    |   |   ├── model
    |           └── Risk_Parity.py
    │ 
    │
    └── tox.ini            <- tox file with settings for running tox; see tox.readthedocs.io


--------

