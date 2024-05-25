from data_loading.data import LoadingData
from Models.arima.arima import ARIMA
from Forecasting.ts_tools.tools.tools import tools
from ts_tools.Dickey_fuller.DF import adf_test
from ts_tools.Dickey_fuller.DF import difference_series
from ts_tools.Dickey_fuller.DF import log_difference_series


# Load the data
loader = LoadingData(tickers=['AAPL'])
ts = loader.get_data()
info = loader.get_info_ticker()

ts_tools = tools()
ts = ts_tools.ts_prepartion(ts, 'Date', 'Adj Close')
ts_tools.plot(ts)

ts_diff = difference_series(ts, 'Adj Close')

# Realizamos el test de Dickey-Fuller en la serie diferenciada
adf_result = adf_test(ts_diff)

# Si la serie diferenciada no es estacionaria, aplicamos la diferenciación logarítmica
if adf_result[1] > 0.05:
    ts_log_diff = log_difference_series(ts, 'Adj Close')
    adf_log_result = adf_test(ts_log_diff)
    ts_diff = ts_log_diff

# Graficar la serie diferenciada (o log-diferenciada)
plt.figure(figsize=(10, 6))
plt.plot(ts_diff, label='Differenced Series')
plt.title('Differenced Time Series')
plt.xlabel('Date')
plt.ylabel('Differenced Value')
plt.legend()
plt.show()


