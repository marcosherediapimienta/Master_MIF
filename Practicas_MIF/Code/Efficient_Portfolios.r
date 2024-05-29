# Este fragmento de código realiza las siguientes tareas:
matriz_covarianzas <- matrix(c(2.1417, 1.2794, 0.9393, 2.1063, 0.115, 0.9938, 2.2096, 1.1006,
                               1.2794, 3.1324, 0.5047, 1.6056, 0.3173, 0.8958, 1.8004, 0.3141,
                               0.9393, 0.5047, 1.3242, 1.6572, 0.2843, 0.7843, 1.5458, 0.8931,
                               2.1063, 1.6056, 1.6572, 5.9285, 1.3357, 1.8079, 5.1644, 1.9824,
                               0.115, 0.3173, 0.2843, 1.3357, 1.2601, 0.5152, 1.0384, -0.0393,
                               0.9938, 0.8958, 0.7843, 1.8079, 0.5152, 0.9833, 1.716, 0.7806,
                               2.2096, 1.8004, 1.5458, 5.1644, 1.0384, 1.716, 5.1163, 1.5551,
                               1.1006, 0.3141, 0.8931, 1.9824, -0.0393, 0.7806, 1.5551, 1.9623), 
                             nrow = 8, byrow = TRUE)

# Este fragmento de código realiza cálculos de optimización de cartera. Aquí hay un desglose de lo que
# hace cada parte:
inversa_covarianzas <- solve(matriz_covarianzas)
print(inversa_covarianzas)

Vector1 <- rep(1, 8)
v1 <- inversa_covarianzas %*% Vector1
Wg <- v1 / sum(v1)
print(Wg)

z <- c(0.3041, 0.2488, 0.2257, 0.6158, 0.1372, 0.2445, 0.5979, 0.2222)
Wd <- inversa_covarianzas %*% z  / sum(inversa_covarianzas %*% z)
print(Wd)


# El fragmento de código que proporcionó realiza cálculos relacionados con la optimización de la
# cartera. Aquí hay un desglose de lo que hace cada parte:

# Calcular 1' * Σ^(-1) * 1
suma_unos <- t(rep(1, length(z))) %*% inversa_covarianzas %*% rep(1, length(z))
print(paste("1' * Σ^(-1) * 1:", suma_unos))

# Calcular 1' * Σ^(-1) * μ  = μ' * Σ^(-1) * 1
producto_unos_mu <- t(rep(1, length(z))) %*% inversa_covarianzas %*% z
print(paste("1' * Σ^(-1) * μ:", producto_unos_mu))

# Calcular μ' * Σ^(-1) * μ
producto_mu_mu <- t(z) %*% inversa_covarianzas %*% z
print(paste("μ' * Σ^(-1) * μ:", producto_mu_mu))


# El fragmento de código que proporcionó calcula los rendimientos y las variaciones esperados para dos
# carteras diferentes (wg y wd) en función de la matriz de covarianza proporcionada y un conjunto de
# ponderaciones. A continuación se muestra un desglose de lo que hace cada parte del código:

rendimiento_esperado_wd <-producto_mu_mu / producto_unos_mu
rendimiento_esperado_wg <- producto_unos_mu / suma_unos
varianza_wg <- 1 / suma_unos
varianza_wd <- producto_mu_mu / (producto_unos_mu)^2

print(paste("Rendimiento esperado de la cartera wg:", rendimiento_esperado_wg))
print(paste("Rendimiento esperado de la cartera wd:", rendimiento_esperado_wd))
print(paste("Varianza de la cartera wg:", varianza_wg))
print(paste("Varianza de la cartera wd:", varianza_wd))



# Esta parte del código calcula el rendimiento esperado de una cartera denominada i_w^lambda, donde
# lambda es un parámetro dado (en este caso, lambda = 0,7). El rendimiento esperado de i_w^lambda es
# un promedio ponderado de los rendimientos esperados de dos carteras diferentes (wg y wd) según el
# parámetro lambda.

# Calcular el rendimiento esperado de i_w^lambda
lambda <- 0.7
rendimiento_esperado_i_w_lambda <- (1-lambda) * rendimiento_esperado_wg + lambda * rendimiento_esperado_wd
print(paste("Rendimiento esperado de i_w^lambda:", rendimiento_esperado_i_w_lambda))



# Esta parte del código realiza un análisis de descomposición de riesgos para una cartera. Aquí hay un
# desglose de lo que hace:

#Descomposición del riesgo

z <- c(0.3041, 0.2488, 0.2257, 0.6158, 0.1372, 0.2445, 0.5979, 0.2222)

LambdaT1 <- (0.3041 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT2 <- (0.2488 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT3 <- (0.2257 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT4 <- (0.6158 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT5 <- (0.1372 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT6 <- (0.2445 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT7 <- (0.5979 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)
LambdaT8 <- (0.2222 - rendimiento_esperado_wg) / (rendimiento_esperado_wd - rendimiento_esperado_wg)

Varianza_Lambda1 <- varianza_wg + (LambdaT1^2) * (varianza_wd - varianza_wg)
Varianza_Lambda2 <- varianza_wg + (LambdaT2^2) * (varianza_wd - varianza_wg)
Varianza_Lambda3 <- varianza_wg + (LambdaT3^2) * (varianza_wd - varianza_wg)
Varianza_Lambda4 <- varianza_wg + (LambdaT4^2) * (varianza_wd - varianza_wg)
Varianza_Lambda5 <- varianza_wg + (LambdaT5^2) * (varianza_wd - varianza_wg)
Varianza_Lambda6 <- varianza_wg + (LambdaT6^2) * (varianza_wd - varianza_wg)
Varianza_Lambda7 <- varianza_wg + (LambdaT7^2) * (varianza_wd - varianza_wg)
Varianza_Lambda8 <- varianza_wg + (LambdaT8^2) * (varianza_wd - varianza_wg)

# Calcular el riesgo inevitable σg^2 (para todos los títulos)

riesgo_g <- varianza_wg

# Calcular el riesgo sistemático σm^2 - σg^2

riesgo_sistematico1 <- Varianza_Lambda1 - riesgo_g
riesgo_sistematico2 <- Varianza_Lambda2 - riesgo_g
riesgo_sistematico3 <- Varianza_Lambda3 - riesgo_g
riesgo_sistematico4 <- Varianza_Lambda4 - riesgo_g
riesgo_sistematico5 <- Varianza_Lambda5 - riesgo_g
riesgo_sistematico6 <- Varianza_Lambda6 - riesgo_g
riesgo_sistematico7 <- Varianza_Lambda7 - riesgo_g
riesgo_sistematico8 <- Varianza_Lambda8 - riesgo_g


# Calcular el riesgo diversificable σp^2 - σm^2

riesgo_diversificable1 <- 2.1417 - Varianza_Lambda1 
riesgo_diversificable2 <- 3.1324 - Varianza_Lambda2
riesgo_diversificable3 <- 1.3242 - Varianza_Lambda3
riesgo_diversificable4 <- 5.9285 - Varianza_Lambda4
riesgo_diversificable5 <- 1.2601 - Varianza_Lambda5
riesgo_diversificable6 <- 0.9833 - Varianza_Lambda6
riesgo_diversificable7 <- 5.1163 - Varianza_Lambda7
riesgo_diversificable8 <- 1.9623 - Varianza_Lambda8


print(LambdaT1)
print(LambdaT2)
print(LambdaT3)
print(LambdaT4)
print(LambdaT5)
print(LambdaT6)
print(LambdaT7)
print(LambdaT8)

print(Varianza_Lambda1)
print(Varianza_Lambda2)
print(Varianza_Lambda3)
print(Varianza_Lambda4)
print(Varianza_Lambda5)
print(Varianza_Lambda6)
print(Varianza_Lambda7)
print(Varianza_Lambda8)

print(riesgo_g)

print(riesgo_sistematico1)
print(riesgo_sistematico2)
print(riesgo_sistematico3)
print(riesgo_sistematico4)
print(riesgo_sistematico5)
print(riesgo_sistematico6)
print(riesgo_sistematico7)
print(riesgo_sistematico8)

print(riesgo_diversificable1)
print(riesgo_diversificable2)
print(riesgo_diversificable3)
print(riesgo_diversificable4)
print(riesgo_diversificable5)
print(riesgo_diversificable6)
print(riesgo_diversificable7)
print(riesgo_diversificable8)