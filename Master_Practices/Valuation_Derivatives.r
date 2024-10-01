if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
library(ggplot2)


# La función "vega" calcula la Vega de una opción, que mide la sensibilidad del precio de la opción a
# los cambios en la volatilidad del activo subyacente. Toma los parámetros "S" (precio actual de las
# acciones), "K" (precio de ejercicio), "T" (tiempo hasta el vencimiento), "r" (tasa libre de riesgo),
# "sigma" (volatilidad) y "d1". ` (un parámetro utilizado en la fórmula de Black-Scholes) para
# calcular el valor de Vega. La fórmula `sqrt(T) * S * dnorm(d1)` calcula Vega basándose en el modelo
# de Black-Scholes.

# Función para la vega
vega <- function(S, K, T, r, sigma, d1) {
  sqrt(T) * S * dnorm(d1)
}

# La función `newton_method` implementa el método Newton-Raphson para encontrar la volatilidad
# implícita de una opción dado su precio de mercado. A continuación se muestra un desglose de lo que
# hace la función:

# Función para el método de Newton
newton_method <- function(S, K, T, r, V, sigma_guess, tolerance = 1e-6, max_iter = 100) {
  x_k <- sigma_guess
  for (iter in 1:max_iter) {
    d1 <- (log(S / K) + (r + (x_k^2) / 2) * T) / (x_k * sqrt(T))
    f_value <- S * pnorm(d1) - K * exp(-r * T) * pnorm(d1 - x_k * sqrt(T)) - V
    f_prime <- vega(S, K, T, r, x_k, d1)
    
    x_k1 <- x_k - f_value / f_prime
    
    if (abs(f_value) < tolerance && abs(x_k1 - x_k) < tolerance) {
      break
    }
    
    x_k <- x_k1
  }
  
  return(x_k)
}

# Datos proporcionados
T <- 0.211
S <- 5290.36
r <- 0.0328

# Pares K, V de la tabla
data <- data.frame(
  K = c(6000, 6200, 6300, 6350, 6400, 6600, 6800),
  V = c(80.2, 47.1, 35.9, 31.3, 27.7, 16.6, 11.4)
)

# Esta parte del código calcula las volatilidades implícitas para los datos de opciones dados
# utilizando el método Newton-Raphson.

# Calcular volatilidades implícitas
data$ImpliedVolatility <- sapply(1:nrow(data), function(i) {
  newton_method(S, data$K[i], T, r, data$V[i], sigma_guess = 0.2)
})

result_table <- data.frame(
  Strike = data$K,
  ImpliedVolatility = data$ImpliedVolatility
)

print(result_table)

 
# La función `black_scholes_call` se utiliza para calcular el precio teórico de una opción de compra
# utilizando el modelo de Black-Scholes. A continuación se muestra un desglose de lo que hace la
# función:

# Función para calcular el precio teórico de una opción de compra utilizando el modelo de Black-Scholes
black_scholes_call <- function(S0, K, T, r, sigma) {
  d1 <- (log(S0 / K) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T))
  d2 <- d1 - sigma * sqrt(T)
  
  call_price <- S0 * pnorm(d1) - K * exp(-r * T) * pnorm(d2)
  return(call_price)
}

# Parámetros
S0 <- 100      # Precio inicial de la acción
K <- 100       # Precio de ejercicio de la opción
T <- 1         # Tiempo hasta el vencimiento en años
r <- 0.05      # Tasa libre de riesgo

# Rango de volatilidades implícitas a probar
volatilities <- seq(0.1, 0.5, by = 0.05)

# Calcular precios teóricos de la opción para diferentes volatilidades implícitas
option_prices <- sapply(volatilities, function(sigma) {
  black_scholes_call(S0, K, T, r, sigma)
})

results <- data.frame(Volatilidad_Implícita = volatilities, Precio_Opción = option_prices)
results

ggplot(results, aes(x = Volatilidad_Implícita, y = Precio_Opción)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Impacto de la Volatilidad Implícita en el Precio de la Opción de Compra",
       x = "Volatilidad Implícita",
       y = "Precio de la Opción") +
  theme_minimal()


# Parámetros
S0 <- 100    # Precio inicial de la acción
K <- 100     # Precio de ejercicio de la opción
T <- 1       # Tiempo hasta el vencimiento en años
r <- 0.05    # Tasa libre de riesgo
num_simulations <- 1000000  # Número de simulaciones

# Configurar la semilla para reproducibilidad
set.seed(42)

# La función `option_price` se utiliza para calcular el precio de una opción de compra mediante
# simulación de Monte Carlo. A continuación se muestra un desglose de lo que hace la función:

# Función para calcular el precio de la opción de compra
option_price <- function(volatility) {
  z <- rnorm(num_simulations)
  ST <- S0 * exp((r - 0.5 * volatility^2) * T + volatility * sqrt(T) * z)
  payoff <- pmax(ST - K, 0)
  return(mean(payoff) * exp(-r * T))
}

# Calcular precios de opciones para diferentes volatilidades
volatilities <- seq(0.1, 0.5, by = 0.05)

for (volatility in volatilities) {
  option_price_result <- option_price(volatility)
  cat("Volatilidad:", volatility, "\t Precio estimado de la opción de compra:", option_price_result, "\n")
}



 



