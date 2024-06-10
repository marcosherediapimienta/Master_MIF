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



#Importamos las bibliotecas necesarias: numpy, MinMaxScaler de sklearn.preprocessing y ARIMA de statsmodels.tsa.arima.model.
#Estas bibliotecas se utilizan para manipular datos, escalarlos y ajustar el modelo ARIMA, respectivamente.

#La clase ARIMA es una implementación personalizada de un modelo ARIMA.

#Método __init__: 
#Este es el constructor de la clase. Toma un argumento order, que es una tupla que define el orden del modelo ARIMA (p, d, q).
#Inicializa tres atributos:
#order: almacena el orden del modelo ARIMA.
#scaler_x: un objeto MinMaxScaler para escalar los datos exógenos.
#scaler_y: un objeto MinMaxScaler para escalar los datos endógenos.
#model: inicialmente establecido en None, se utiliza para almacenar el modelo ARIMA ajustado una vez que se llama al método fit.

#Método fit:
#Este método se utiliza para ajustar el modelo ARIMA a los datos proporcionados.
#Toma dos argumentos: data_x y data_y. data_x son los datos exógenos y data_y son los datos endógenos.
#Escala los datos de entrada utilizando MinMaxScaler para mantenerlos en un rango específico (por defecto, de 0 a 1).
#Ajusta el modelo ARIMA a los datos escalados utilizando la función ARIMA_model de statsmodels.
#Guarda el modelo ajustado en el atributo model.

#Método predict:
#Este método se utiliza para realizar predicciones con el modelo ARIMA ajustado.
#Toma un argumento test_x, que son los datos exógenos para los cuales se desean hacer predicciones.
#Escala los datos de entrada test_x utilizando MinMaxScaler.
#Realiza predicciones con el modelo ARIMA ajustado utilizando la función predict.
#Invierte la escala de las predicciones para obtener los valores originales utilizando el método inverse_transform de MinMaxScaler.
#Devuelve las predicciones escaladas.



