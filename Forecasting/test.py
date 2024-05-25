from data_loading.data import LoadingData
from Models.arima import MyArima

# Load the data
loader = LoadingData(tickers=['AAPL','^N225','^GSPC','^DJI','^IBEX','DAX','^IXIC'])
ts = loader.get_data()
info = loader.get_info_ticker()