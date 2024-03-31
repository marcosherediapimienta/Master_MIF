# Instalar y cargar la librería quantmod
if (!requireNamespace("quantmod", quietly = TRUE)) {
  install.packages("quantmod")
}
library(quantmod)

# Este fragmento de código utiliza el paquete `quantmod` en R para recuperar datos diarios de precios
# de acciones para el índice DAX (^GDAXI) y Deutsche Bank (DBK.DE) de Yahoo Finance. A continuación se
# muestra un desglose de lo que hace cada parte del código:

# Obtener datos diarios del DAX
getSymbols("^GDAXI", src = "yahoo", from = "2014-01-01", to = Sys.Date())
df_dax_diario <- as.data.frame(GDAXI)
df_dax_diario <- na.omit(df_dax_diario)

# Obtener datos diarios de Deutsche Bank
getSymbols("DBK.DE", src = "yahoo", from = "2014-01-01", to = Sys.Date())
df_dbk_diario <- as.data.frame(DBK.DE)
df_dbk_diario <- na.omit(df_dbk_diario)

df_dax_diario
df_dbk_diario

#Inspeccionamos los datos
dim(df_dbk_diario)  #(row = sample size, col = variables)
head(df_dbk_diario) # primeras 6 filas
tail(df_dbk_diario) # ultimas 6 filas

dim(df_dax_diario)  #(row = sample size, col = variables)
head(df_dax_diario) # primeras 6 filas
tail(df_dax_diario) # ultimas 6 filas

# Esta parte del código calcula los rendimientos logarítmicos de los precios de las acciones del
# índice DAX (^GDAXI) y del Deutsche Bank (DBK.DE).
# Calcular los log-returns para el DAX
log_returns_dax <- diff(log(df_dax_diario$GDAXI.Adjusted))

# Calcular los log-returns para Deutsche Bank
log_returns_dbk <- diff(log(df_dbk_diario$DBK.DE.Adjusted))

head(log_returns_dax)
head(log_returns_dbk)
