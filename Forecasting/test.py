from data_loading.data import LoadingData
from Models.arima.arima import ARIMA

# Load the data
loader = LoadingData(tickers=['AAPL'])
ts = loader.get_data()
info = loader.get_info_ticker()

