import matplotlib.pyplot as plt
from numpy import arange, cov, diagonal, empty, mean, random

# Parâmetros
N = 1000            # Número de realizações
ns = arange(11)     # Vetor dos tempos (discreto)
ℓs = arange(-5, 6)  # Vetor dos atrasos (discreto)
Na = ns.size        # Número de amostras temporais

# Experimento
X = random.normal(loc=0, scale=1, size=(N, Na))
Y = empty((N, Na))
for i in range(N):
    Y[i, 0] = X[i, 0]
    for n in range(1, Na):
        Y[i, n] = X[i, n] + X[i, n-1]

# Cálculos
# - Médias
mu_X_teo = 0.0
mu_X_sim = mean(X)
mu_Y_teo = 0.0
mu_Y_sim = mean(Y)
# - Funções autocovariância
C_X_teo = 1*(ℓs == 0)
C_X_mat = cov(X, rowvar=False)
C_X_sim = [mean(diagonal(C_X_mat, ℓ)) for ℓ in ℓs]
C_Y_teo = 2*(ℓs == 0) + 1*(ℓs == 1) + 1*(ℓs == -1)
C_Y_mat = cov(Y, rowvar=False)
C_Y_sim = [mean(diagonal(C_Y_mat, ℓ)) for ℓ in ℓs]

# Saída
plt.figure()
# - Realizações
for i in range(3):
    plt.subplot(3, 2, 2*i + 1)
    plt.stem(ns, X[i], markerfmt="C0o", linefmt="C0-", basefmt="none")
    plt.xlabel("$n$")
    plt.ylabel("$X[n]$")
    plt.ylim(-4, 4)
    plt.title(f"Realização {i + 1}")
    plt.grid()
    plt.subplot(3, 2, 2*i + 2)
    plt.stem(ns, Y[i], markerfmt="C1o", linefmt="C1-", basefmt="none")
    plt.xlabel("$n$")
    plt.ylabel("$Y[n]$")
    plt.ylim(-4, 4)
    plt.title(f"Realização {i + 1}")
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
