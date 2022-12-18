Final_Project
==============================

This is the final Project for DTFF

## FILEPATH
In order to avoid using absolute addresses, we define a path variable `FILEPATH` to denote the Root directory for this project, you need to change it when using `MATLAB` codes in `\src` and `R` codes in `\app`. 
1. `MATLAB` codes: you only need to change the `FILEPATH` in the `main_function.m`;
2. `r` codes: you only need to change the `FILEPATH` in the `app.r`;

The example of  `FILEPATH` is:
```
FILEPATH = "C:\Users\Desktop\Digital_Tools_for_Finance";
```
Note: You don't need to change the `FILEPATH` in the python codes unless you can't run the `main.py` directly due to the path error, since we have used `os` to find the absolute path of your root directory automatically.

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
1. The weights of assets in the model; (.xlsx)
2. The net value of portfolio based on different models; (.xlsx)
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
   We use the matlab codes to implement the same model as Python code and draw all of the figures in reports. In order to run the code, you only need to do
   
   open the `main_function.m` in matlab -> install the toolbox `Optimization Toolbox` and `Parallel Computing Toolbox`-> Run `main_function.m` .
   
   All of results would be exported to the folder `data\result\matlab` directly and all of the figures would be shown on your computer at the same time.
 
   **Note**: if you run the codes at first time, please write the function `parpool(n)` in the `main_function.m` to set your parallel computing numbers, n must be smaller than the kernels of your computer. 

## Report and Slides

## Interactive App Based on R Shiny
We create an interactive app using R shiny called `app.R` to show the plots of the daily return, the assets correlation coeffient, weights, and the net values in general cases. Specifically, we can determine `Output` to show the different kinds of plots and choose `Start Date` and `End Date` to determine the date interval.

If you don't want to run by yourself, you can use the link to get the result on website `shinyapps.io`:

[`DTFF-Final-Project-Rshiny-results`](https://sticker98.shinyapps.io/shiny/?_ga=2.200801197.263085363.1671393522-251602509.1671393522)


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

