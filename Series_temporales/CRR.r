# Parámetros del modelo CRR

r <- 0.04  # Tasa de interés libre de riesgo
u <- 1.06  # Factor de aumento
d <- 0.98  # Factor de disminución
S0 <- 20   # Precio inicial de la acción en euros
N <- 4     # Número de pasos de tiempo


# Calcular la probabilidad neutral al riesgo (p)
p <- (1 + r - d) / (u - d)
q <- 1 - p
cat("La probabilidad neutral al riesgo es:", p, "\n")

binomial_tree <- matrix(NA, nrow = N + 1, ncol = N + 1)

# Calcular los precios de la acción en cada nodo del árbol binomial
for (i in 0:N) {
  for (j in 0:i) {
    binomial_tree[j + 1, i + 1] <- S0 * u^j * d^(i - j)
  }
}

print(binomial_tree)

