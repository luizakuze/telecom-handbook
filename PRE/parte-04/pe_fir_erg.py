import matplotlib.pyplot as plt
from numpy import arange, correlate, empty, mean, random

# Parâmetros
ns = arange(10_000)  # Vetor dos tempos (discreto)
ℓs = arange(-5, 6)   # Vetor dos atrasos (discreto)
Na = ns.size         # Número de amostras temporais

# Esta solução utiliza o fato de que X[n] e Y[n] são
# ergódicos na média e na autocovariância.

# Experimento
X = random.normal(loc=0, scale=1, size=Na)
Y = empty(Na)
Y[0] = X[0]
for n in range(1, Na):
    Y[n] = X[n] + X[n-1]

# Cálculos
# - Médias
mu_X_teo = 0.0
mu_X_sim = mean(X)
mu_Y_teo = 0.0
mu_Y_sim = mean(Y)
# - Funções autocovariância
C_X_teo = 1*(ℓs == 0)
C_X_sim = correlate(X, X, mode='full')[Na - 1 + ℓs] / Na
C_Y_teo = 2*(ℓs == 0) + 1*(ℓs == 1) + 1*(ℓs == -1)
C_Y_sim = correlate(Y, Y, mode='full')[Na - 1 + ℓs] / Na

# Saída
plt.figure()
# - Realizações
plt.subplot(2, 1, 1)
plt.stem(ns[:20], X[:20], markerfmt="C0o", linefmt="C0-", basefmt="none")
plt.xlabel("$n$")
plt.ylabel("$X[n]$")
plt.ylim(-4, 4)
plt.grid()
plt.subplot(2, 1, 2)
plt.stem(ns[:20], Y[:20], markerfmt="C1o", linefmt="C1-", basefmt="none")
plt.xlabel("$n$")
plt.ylabel("$Y[n]$")
plt.ylim(-4, 4)
plt.grid()
plt.tight_layout()
# - Médias
print(f"Teo: E[X] = {mu_X_teo:.4f}")
print(f"Sim: E[X] = {mu_X_sim:.4f}")
print(f"Teo: E[Y] = {mu_Y_teo:.4f}")
print(f"Sim: E[Y] = {mu_Y_sim:.4f}")
# - Funções autocovariância
plt.figure()
plt.subplot(2, 1, 1)
plt.stem(ℓs, C_X_teo, markerfmt="C0o", linefmt="C0-", basefmt="none", label="Teórico")
plt.stem(ℓs, C_X_sim, markerfmt="C1o", linefmt="C1-", basefmt="none", label="Simulado")
plt.legend()
plt.xlabel("$\\ell$")
plt.ylabel("$C_X[\\ell]$")
plt.grid()
plt.subplot(2, 1, 2)
plt.stem(ℓs, C_Y_teo, markerfmt="C0o", linefmt="C0-", basefmt="none", label="Teórico")
plt.stem(ℓs, C_Y_sim, markerfmt="C1o", linefmt="C1-", basefmt="none", label="Simulado")
plt.legend()
plt.xlabel("$\\ell$")
plt.ylabel("$C_Y[\\ell]$")
plt.grid()
plt.tight_layout()
plt.show()
