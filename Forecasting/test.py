from data_loading.data import LoadingData
from Models.arima.arima import ARIMA
from ts_tools.tools.tools import tools
from ts_tools.Dickey_fuller.DF import adf_test
from ts_tools.Dickey_fuller.DF import difference_series
from ts_tools.Dickey_fuller.DF import log_difference_series
from statsmodels.tsa.stattools import adfuller
import matplotlib.pyplot as plt


# Load the data
loader = LoadingData(tickers=['AAPL'])
ts = loader.get_data()
info = loader.get_info_ticker()
print('Información cargada')

ts_tools = tools()
ts = ts_tools.ts_prepartion(ts, 'Date', 'Adj Close')
ts_tools.plot(ts)
print('Datos preparados')

ts_diff = difference_series(ts, 'ds' ,'y')
ts_tools.plot(ts_diff)

print('Cargando Arima...')
arima = ARIMA()
fitting_model = arima.fit(ts_diff)
forecast_model = arima.predict(ts_diff)

print(forecast_model)
