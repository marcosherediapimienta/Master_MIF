install.packages(c("tidyverse", "tseries", "forecast"))
install.packages("TSA")
install.packages("vars")
if (!requireNamespace("gvlma", quietly = TRUE)) {
  install.packages("gvlma")}

library(tidyverse)
library(tseries)
library(forecast)
library(TSA)
library(gvlma)
library(ggplot2)
library(urca)
library(vars)


df_bbva <- read.table("../Ficheros/BBVA.txt", header = TRUE)
df_san <- read.table("../Ficheros/SAN.txt", header = TRUE)
df_san2 <- read.table("../Ficheros/SAN2.txt", header = TRUE, sep = ",")

bbva_series <- ts(df_bbva$BBVA.Adjusted, frequency = 1)
png("../Resultados/Practica_con_integracion/Cotizaciones_BBVA.png")
plot(bbva_series, main = "Cotizaciones diarias del BBVA")
dev.off()

SAN_series <- ts(df_san$SAN.Adjusted, frequency = 1)

png("../Resultados/Practica_con_integracion/SAN_series_plot.png")
plot(SAN_series, main = "Cotizaciones diarias del SANTANDER")
dev.off()

adf_test <- adf.test(bbva_series)
print(adf_test)
adf_test <- adf.test(SAN_series)
print(adf_test)

# El fragmento de código que proporcionó ajusta un modelo ARIMA a los datos de series temporales de
# los precios de las acciones de BBVA y SANTANDER.
arima_model <- auto.arima(bbva_series)
arima_model
summary(arima_model)

arima_model <- auto.arima(SAN_series)
arima_model
summary(arima_model)


forecast_result <- forecast(arima_model, h = 8)  # 8 periodos de predicción
forecast_result

plot(forecast_result, main = "Predicciones con modelo ARIMA")

#3

#Analsis de los residuos

residuos <- resid(arima_model)

# Realizar la prueba de Ljung-Box en los residuos
# El fragmento de código que proporcionó realiza una prueba de Ljung-Box para la autocorrelación en
# los residuos de un modelo de serie temporal. A continuación se muestra un desglose de lo que hace
# cada parte del código:

ljung_box_result <- Box.test(residuos, lag = 20, type = "Ljung-Box")
cat("Prueba de Ljung-Box para autocorrelación en residuos:\n")
print(ljung_box_result)

# Gráficos de Residuos
par(mfrow=c(2,2))
plot(residuos, main="Gráficos de Residuos")

# Histograma de Residuos
hist(residuos, main="Histograma de Residuos")

# Prueba de Autocorrelación de Residuos
acf(residuos, main="Autocorrelación de Residuos")

# Prueba de Normalidad de Residuos
shapiro.test(residuos)

# Pronóstico Residuo
resid_forecast <- forecast(arima_model, h=10)$residuals
resid_forecast
plot(resid_forecast, main="Pronóstico de Residuos")

# Q-Q Plot
qqnorm(residuos)
qqline(residuos)

# Gráfico de Residuos con Líneas de Referencia
plot(residuos, main="Gráfico de Residuos con Líneas de Referencia", ylab="Residuos")
abline(h = 0, col = "red", lty = 2)  # Línea base para homocedasticidad

# Residuos al cuadrado
residuos_cuadrados <- residuos^2

# Gráfico de Residuos al Cuadrado vs. Predicciones
plot(residuos_cuadrados ~ fitted(arima_model), main="Gráfico de Residuos al Cuadrado vs. Predicciones", ylab="Residuos al Cuadrado")
abline(h = mean(residuos_cuadrados), col = "red", lty = 2)  # Línea base para homocedasticidad

#Test de Breusch-Pagan (homoscedasticidad)

# Ajustar modelo ARIMA(1,1,0)
arima_model <- arima(bbva_series, order = c(1, 1, 0))

# Obtener residuos del modelo
residuos <- residuals(arima_model)

# Ajustar un modelo de regresión lineal de los residuos al cuadrado
lm_model <- lm(residuos^2 ~ 1)

# Obtener la estadística de prueba de Breusch-Pagan manualmente
bp_test_stat <- sum(resid(lm_model)^2)
bp_test_df <- length(residuos)
bp_test_p_value <- 1 - pchisq(bp_test_stat, df = 1)  # 1 grado de libertad en el modelo de regresión

# Mostrar resultados
cat("Estadística de prueba de Breusch-Pagan:", bp_test_stat, "\n")
cat("Grados de libertad:", 1, "\n")
cat("Valor p:", bp_test_p_value, "\n")


#4

#Cointegración

san_series <- ts(df_san$SAN.Adjusted, frequency = 1)
bbva_series <- ts(df_bbva$BBVA.Adjusted, frequency = 1)

# Realizar la prueba de Engle-Granger
cointegration_test <- ca.jo(cbind(san_series, bbva_series), K = 2, type = "trace", ecdet = "none")
cointegration_test
summary(cointegration_test)

# Seleccionar las series relevantes
san_series <- df_san$SAN.Adjusted
bbva_series <- df_bbva$BBVA.Adjusted

# Crear un dataframe con las series
df <- data.frame(Santander = san_series, BBVA = bbva_series)

# Ajustar modelo de regresión para obtener la relación de cointegración
lm_model <- lm(BBVA ~ Santander, data = df)

# Obtener los coeficientes del modelo de regresión
intercept <- coef(lm_model)[1]
slope <- coef(lm_model)[2]

# Crear un gráfico de dispersión con la línea de cointegración
ggplot(df, aes(x = Santander, y = BBVA)) +
  geom_point() +
  geom_abline(intercept = intercept, slope = slope, color = "red", linetype = "dashed") +
  labs(title = "Gráfico de Dispersión con Línea de Cointegración",
       x = "Santander",
       y = "BBVA")

#5

df_bbva <- read.table("../Ficheros/BBVA.txt", header = TRUE)
df_SAN <- read.table("../Ficheros/SAN.txt", header=TRUE)
df_SAN2 <- read.table("../Ficheros/SAN2.txt", header = TRUE, sep = ",") 

bbva_series <- ts(df_bbva$BBVA.Adjusted, frequency = 1)
san_series <- ts(df_SAN$SAN.Adjusted, frequency = 1)

# Combinar series temporales
data_matrix <- cbind(bbva_series, san_series)

# Realizar la prueba de Johansen
johansen_test <- ca.jo(data_matrix, ecdet = "none", type = "trace", K = 2)
summary(johansen_test)

# Extraer vectores cointegrantes
coint_vecs <- johansen_test@V
coint_vecs

#Modelar la relación de error de corrección (VEC)
vec_model <- vec2var(johansen_test, r = 1)
summary(vec_model)

# Obtener los residuos del modelo VEC
residuos2 <- residuals(vec_model)
residuos2
plot(residuos2, main = "Gráfico de Residuos VEC")
shapiro.test(residuos2)

# Ajustar un modelo de regresión lineal de los residuos al cuadrado
lm_model <- lm(residuos2^2 ~ 1)
  
# Obtener la estadística de prueba de Breusch-Pagan manualmente
bp_test_stat <- sum(resid(lm_model)^2)
bp_test_df <- length(residuos2)
bp_test_p_value <- 1 - pchisq(bp_test_stat, df = 1)  # 1 grado de libertad en el modelo de regresión

# Mostrar resultados
cat("Estadística de prueba de Breusch-Pagan:", bp_test_stat, "\n")
cat("Grados de libertad:", 1, "\n")
cat("Valor p:", bp_test_p_value, "\n")

# Gráficos de Residuos
par(mfrow=c(2,2))
plot(residuos2, main="Gráficos de Residuos")

# Histograma de Residuos
hist(residuos2, main="Histograma de Residuos")

# Prueba de Autocorrelación de Residuos
acf(residuos2, main="Autocorrelación de Residuos")

# Q-Q Plot
qqnorm(residuos2)
qqline(residuos2)

# Extraer los residuos del modelo VEC como un vector
residuos2 <- as.vector(residuals(vec_model))

# Realizar la prueba de Ljung-Box en los residuos
ljung_box_result <- Box.test(residuos2, lag = 20, type = "Ljung-Box")

# Mostrar el resultado
cat("Prueba de Ljung-Box para autocorrelación en residuos:\n")
print(ljung_box_result)

#6

# Supongamos que ya tienes los modelos ajustados (arima_model y vec_model)
arima_aic <- AIC(arima_model)
arima_bic <- BIC(arima_model)

vec_aic <- AIC(vec_model)
vec_bic <- BIC(vec_model)

cat("ARIMA - AIC:", arima_aic, "BIC:", arima_bic, "\n")
cat("VEC - AIC:", vec_aic, "BIC:", vec_bic, "\n")
