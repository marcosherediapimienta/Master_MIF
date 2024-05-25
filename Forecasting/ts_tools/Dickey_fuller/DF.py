import numpy as np
import pandas as pd
from statsmodels.tsa.stattools import adfuller
import matplotlib.pyplot as plt

# Diferenciación de la serie temporal
def difference_series(ts, Adj Close):
    ts_diff = ts[column].diff().dropna()
    return ts_diff

# Aplicar test de Dickey-Fuller
def adf_test(series):
    result = adfuller(series)
    print('ADF Statistic:', result[0])
    print('p-value:', result[1])
    for key, value in result[4].items():
        print(f'Critical Value ({key}): {value}')
    return result

# Diferenciación logarítmica
def log_difference_series(ts, Adj Close):
    ts_log_diff = np.log(ts[Adj Close]).diff().dropna()
    return ts_log_diff