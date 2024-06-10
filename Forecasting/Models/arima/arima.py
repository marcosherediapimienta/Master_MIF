import numpy as np
from statsmodels.tsa.arima.model import ARIMA as ARIMA_model
from sklearn.preprocessing import MinMaxScaler

class ARIMA:
    def __init__(self, order):
        self.order = order
        self.scaler_x = MinMaxScaler(feature_range=(0, 1))
        self.scaler_y = MinMaxScaler(feature_range=(0, 1))
        self.model = None

    def fit(self, data_x, data_y):
        train_x = self.scaler_x.fit_transform(data_x)
        train_y = self.scaler_y.fit_transform(data_y.reshape(-1, 1))
        self.model = ARIMA_model(train_y, exog=train_x, order=self.order).fit()

    def predict(self, test_x):
        test_x = self.scaler_x.transform(test_x)
        pred_y = self.model.predict(start=self.model.nobs, end=self.model.nobs + len(test_x) - 1, exog=test_x)
        return self.scaler_y.inverse_transform(pred_y.reshape(-1, 1))
