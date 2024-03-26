# Parámetros del modelo CRR

r <- 0.04  # Tasa de interés libre de riesgo
u <- 1.06  # Factor de aumento
d <- 0.98  # Factor de disminución
S0 <- 20   # Precio inicial de la acción en euros
N <- 3     # Número de pasos de tiempo

# (a) Compute the risk neutral probability

# Calcular la probabilidad neutral al riesgo (p)
p <- (1 + r - d) / (u - d)
q <- 1 - p
cat("La probabilidad neutral al riesgo es:", p, "\n")



# (b) Construct the binomial tree for Sn.

binomial_tree <- matrix(NA, nrow = N + 1, ncol = N + 1)

# Calcular los precios de la acción en cada nodo del árbol binomial
for (i in 0:N) {
  for (j in 0:i) {
    binomial_tree[j + 1, i + 1] <- S0 * u^j * d^(i - j)
  }
}

print(binomial_tree)

# Definir los resultados de S3
resultados_S4 <- c(23.82, 22.02, 20.36, 18.82)

# Calcular los payoffs para cada uno de los resultados de S3
payoffs <- resultados_S4 - S0
print(payoffs)



# (c) Compute the probabilities of S3. Check that their sum is 1.

# Definir la probabilidad neutral al riesgo
p <- 0.75
q <- 0.25

# Calcular las probabilidades de cada valor específico de X

# Para X = 3.82
prob_X_382 <- p^3
cat("P(X = 3.82) =", prob_X_382, "\n")

# Para X = 2.02
prob_X_202 <- 3 * p^2 * q
cat("P(X = 2.02) =", prob_X_202, "\n")

# Para X = 0.36
prob_X_036 <- 3 * p * q^2
cat("P(X = 0.36) =", prob_X_036, "\n")

#Para X = 0
prob_X_0 <- q^3
cat("P(X = 0)=", prob_X_0, "\n")

total_prob <- sum(prob_X_382, prob_X_202, prob_X_036, prob_X_0)
cat("La suma total de las probabilidades es:", total_prob, "\n")



#(d) Compute V3= (S3 - 20)+, and make a backward recursion in order to determine V3; V2; V1; V0

V3.1 <- 3.82
V3.2 <- 2.02
V3.3 <- 0.36
V3.4 <- 0

V2.1 <- ((V3.1 * 0.75) + (V3.2 * 0.25)) / 1.04
V2.2 <- ((V3.2 * 0.75) + (V3.3 * 0.25)) / 1.04
V2.3 <- ((V3.3 * 0.75) + (V3.4 * 0.25)) / 1.04

V1.1 <- ((V2.1 * 0.75) + (V2.2 * 0.25)) / 1.04
V1.2 <- ((V2.2 * 0.75) + (V2.3 * 0.25)) / 1.04

V0.1 <- ((V1.1 * 0.75) + (V1.2 * 0.25)) / 1.04

cat("V3.1:", V3.1, "\n")
cat("V3.2:", V3.2, "\n")
cat("V3.3:", V3.3, "\n")
cat("V3.4:", V3.4, "\n")

cat("V2.1:", V2.1, "\n")
cat("V2.2:", V2.2, "\n")
cat("V2.3:", V2.3, "\n")

cat("V1.1:", V1.1, "\n")
cat("V1.2:", V1.2, "\n")

cat("V0.1:", V0.1, "\n")



# (e) First check of V0: Compute (1 + r)^-N*E[(SN - K)+]:

# Calcular el valor esperado de X
E_X <- sum(3.82*prob_X_382+2.02*prob_X_202+0.36*prob_X_036+0*prob_X_0)

# Calcular el precio de la opción call
r <- 0.04  # Tasa de interés libre de riesgo
V0 <- ((1+0.04)^-3) * E_X

# Imprimir el precio de la opción call
cat("El precio de la opción call es:", V0)



#(g) Compute the replicating portfolio assuming the following values of Sn:

S0 <- 20
S1 <- 21.2
S2 <- 20.78
S3 <- 22.02
d <- 0.98
u <- 1.06


#T = 0

H1 <- (V1.1-V1.2) / (u-d) * S0
D1 <- (V1.1-(H1*S1)) / (1+0.04)

#T = 1

H2 <- (V2.1-V2.2) / (u-d)*S1
D1 <- (V1.1-(H2*S1)) / (1+0.04)

#




