Final_Project
==============================

This is the final Project for DTFF

## Codes and Environments
--------------------------
We offer two types of codes for this project: `Python` and `Matlab`, you can run all of them using your IDE and the environment setting would be given later. For `Python` code, we also offer a way to run it in `docker`, while we only offer a simple dockerfile for matlab code since you need to update some toolboxes by yourself.
### 1.Python Codes
We use the python code to implement the risk parity model in our report, while it would only give you the results of the model which include:
1. The weights of assets; (.xlsx)
2. The net value of portfolio; (.xlsx)
and all of figures in the report are drawn by MATLAB code.

All of the python codes are given in the folder `src\python`, you can run it in the ways
1. Your own IDE and install all the packages in the file `requirements.txt`.
2. We also give you the environment export `DTFF-Final-Project.yml`, you can run it in `vscode` under `conda` environment.
3. Run it in `docker`. If you want to do this, please see the folder `docker\python`, what you need to do is
   1) Go in the folder `docker\python` using command Lines;
   2) Open the docker and run the command line:
   ```
   ```
   and 
   ```
   ```
   3) Then you would see all of the results are shown in the folder `docker\python\data\result`.
   

### 2.Matlab Codes     
   We use the matlab codes to implement the same model as Python code, but all of the figures are                      



Project Organization
------------

    ├── LICENSE
    ├── Makefile           <- Makefile with commands like `make data` or `make train`
    ├── README.md          <- The top-level README for developers using this project.
    ├── data
    │   ├── external       <- Data from third party sources.
    │   ├── interim        <- Intermediate data that has been transformed.
    │   ├── processed      <- The final, canonical data sets for modeling.
    │   └── raw            <- The original, immutable data dump.
    │
    ├── docs               <- A default Sphinx project; see sphinx-doc.org for details
    │
    ├── models             <- Trained and serialized models, model predictions, or model summaries
    │
    ├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
    │                         the creator's initials, and a short `-` delimited description, e.g.
    │                         `1.0-jqp-initial-data-exploration`.
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
    ├── src                <- Source code for use in this project.
    │   ├── __init__.py    <- Makes src a Python module
    │   │
    │   ├── data           <- Scripts to download or generate data
    │   │   └── make_dataset.py
    │   │
    │   ├── features       <- Scripts to turn raw data into features for modeling
    │   │   └── build_features.py
    │   │
    │   ├── models         <- Scripts to train models and then use trained models to make
    │   │   │                 predictions
    │   │   ├── predict_model.py
    │   │   └── train_model.py
    │   │
    │   └── visualization  <- Scripts to create exploratory and results oriented visualizations
    │       └── visualize.py
    │
    └── tox.ini            <- tox file with settings for running tox; see tox.readthedocs.io


--------

<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
