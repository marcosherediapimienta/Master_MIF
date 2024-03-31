#A)

beta_estimadas <- c(3.087, 0.00014, -0.00064, 0.00275)
desviaciones_estimadas <- c(0.228, 0.00006, 0.00072, 0.00055)

# Nivel de significancia
alpha <- 0.05

# Grados de libertad 
df <- 17 

# Calcular las estadísticas t
estadisticas_t <- beta_estimados / desviaciones_estimadas

# Calcular los valores críticos de la distribución t (bilateral)
valores_criticos <- qt(1 - alpha / 2, df)
p_valores <- 2 * pt(-abs(estadisticas_t), df)

# Determinar la significancia
significancia <- ifelse(abs(estadisticas_t) > valores_criticos, "Significativo", "No significativo")

resultados <- data.frame(Coeficiente = paste("Beta", 1:length(beta_estimados)),
                         Coeficiente_estimado = beta_estimados,
                         Desviacion_estandar = desviaciones_estimadas,
                         Estadistica_t = estadisticas_t,
                         Valor_critico = valores_criticos,
                         P_valor = p_valores,
                         Significancia = significancia)

print(resultados)

#B)

R_cuadrado <- 0.953

# Grados de libertad del modelo
df_modelo <- length(beta_estimadas) - 1

# Grados de libertad del error
df_error <- 17

F_statistic <- (R_cuadrado / df_modelo) / ((1 - R_cuadrado) / df_error)
valor_critico <- qf(1 - alpha, df_modelo, df_error)
p_valor <- pf(F_statistic, df_modelo, df_error, lower.tail = FALSE)

# Imprimir los resultados
print(paste("Estadística F:", F_statistic))
print(paste("Valor p:", p_valor))

# Determinar la significancia
significancia2 <- ifelse(abs(F_statistic) > valor_critico, "Significativo", "No significativo")

resultados2 <- data.frame(Coeficiente = paste("Beta", 1:length(beta_estimados)),
                         Coeficiente_estimado = beta_estimados,
                         Desviacion_estandar = desviaciones_estimadas,
                         F_statistic = F_statistic,
                         valor_critico = valor_critico,
                         P_valor = p_valores,
                         Significancia = significancia)

print(resultados2)





