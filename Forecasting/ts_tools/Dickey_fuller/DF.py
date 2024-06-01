import numpy as np
import pandas as pd
from statsmodels.tsa.stattools import adfuller
import matplotlib.pyplot as plt

# Diferenciación de la serie temporal
def difference_series(ts, column_ds, column_y):
    ts_func = ts.copy()
    columna_diff = ts_func[column_y].diff().dropna()
    ts_func = pd.merge(ts_func, columna_diff, left_index=True, right_index=True)
    ts_func = ts_func[[column_ds, 'y_y']].rename(columns={'y_y': 'y'})
    return ts_func

# Aplicar test de Dickey-Fuller
def adf_test(series):
    result = adfuller(series)
    print('ADF Statistic:', result[0])
    print('p-value:', result[1])
    for key, value in result[4].items():
        print(f'Critical Value ({key}): {value}')
    return result

# Diferenciación logarítmica
def log_difference_series(ts, column):
    ts_log_diff = np.log(ts[column]).diff().dropna()
    return ts_log_diff