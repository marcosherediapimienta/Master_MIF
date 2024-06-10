from sklearn.preprocessing import MinMaxScaler
from statsmodels.tsa.statespace.sarimax import SARIMAX
import numpy as np

class Sarimax:
    def __init__(self, order, seasonal_order, enforce_invertibility=True, enforce_stationarity=True):
        self.order = order
        self.seasonal_order = seasonal_order
        self.enforce_invertibility = enforce_invertibility
        self.enforce_stationarity = enforce_stationarity
        self.sc_in = MinMaxScaler(feature_range=(0, 1))
        self.sc_out = MinMaxScaler(feature_range=(0, 1))

    def fit(self, data_x, data_y):
        train_x = self.sc_in.fit_transform(data_x)
        train_y = self.sc_out.fit_transform(data_y.reshape(-1, 1))
        self.model = SARIMAX(endog=train_y, exog=train_x, order=self.order, seasonal_order=self.seasonal_order,
                             enforce_invertibility=self.enforce_invertibility,
                             enforce_stationarity=self.enforce_stationarity)
        self.result = self.model.fit()

    def predict(self, test_x):
        test_x = self.sc_in.transform(test_x)
        pred_y = self.result.predict(start=self.train_size, end=self.train_size + self.test_size - 1, exog=test_x)
        return self.sc_out.inverse_transform(pred_y.reshape(-1, 1))
