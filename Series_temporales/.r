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

