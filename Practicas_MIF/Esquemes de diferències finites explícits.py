import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import math

# Declaramos las variables que utilizaremos
E = 10
T = 0.5
r = 0.05
sigma = 0.2
S1 = 2
S2 = 16
a = np.log(S1 / E)
b = np.log(S2 / E)
M = 80
Mb = math.trunc(M * (b / -a))
h = (-a) / M
N = 50
k = T / N
alpha = k * (sigma ** 2) / (2 * h ** 2)
alpha

# Definimos los vectores y matrices que usaremos
V = np.zeros((M + Mb + 1, N + 1))
x = np.zeros(M + Mb + 1)


# Aplicamos una transformación
for i in range(M + Mb + 1):
    x[i] = a + (i * h)
    
    
# Calculamos la condición inicial
for i in range(M + Mb + 1):
    V[i, 0] = np.maximum(0, (E - E * np.exp(x[i]))*np.exp(-r * (T)) )
    
    
# Calculamos las condiciones de frontera
for i in range(N + 1):
    V[0, i] = (E - S1) * np.exp(-r * (T - i * k))
    V[-1, i] = 0



# Calculamos el resto de la EDP
for i in range(1, N + 1):
    for j in range(1, M + Mb):
        V[j, i] = alpha * V[j - 1, i - 1] + (1 - 2 * alpha) * V[j, i - 1] + alpha * V[j + 1, i - 1]
        
        
#Printamos la evolucion de la edp
S = E*np.exp(x)
# Graficar los resultados
plt.figure(figsize=(10, 6))
for i in range(0, N+1, int(N/5)):
    plt.plot(S, V[:, i], label=f't={i*k:.2f}')
plt.xlabel('Precio del activo subyacente, S')
plt.ylabel('Valor de la opción, V')
plt.legend()
plt.title('Valor de la opción de venta europea usando diferencias finitas')
plt.grid(True)
plt.show()


#Mostramos los valores cercanos al precio de ejercicio
for i in range(M-10,M+10,2):
    print(S[i],V[i, N])     
        