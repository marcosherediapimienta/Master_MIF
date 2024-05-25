from data_loading.data import LoadingData
from Models.arima.arima import ARIMA
from ts_tools.tools import tools

# Load the data
loader = LoadingData(tickers=['AAPL'])
ts = loader.get_data()
info = loader.get_info_ticker()

ts_tools = tools()
ts = ts_tools.ts_prepartion(ts, 'Date', 'Adj Close')
ts_tools.plot(ts)

