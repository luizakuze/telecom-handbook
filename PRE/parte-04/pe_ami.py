import matplotlib.pyplot as plt
from numpy import arange, cov, mean, meshgrid, random, sum, zeros

# Parâmetros
N = 1000         # Número de realizações
ns = arange(11)  # Vetor dos tempos (discreto)
Na = ns.size     # Número de amostras temporais

# Experimento
X = zeros((N, Na))
for i in range(N):
    B = random.randint(0, 2, Na)
    idx = B != 0
    L = sum(idx)
    X[i, idx] = (-1) ** arange(L)

# Cálculos
mu_X_teo = zeros(Na)
mu_X_sim = mean(X, axis=0)
nn1, nn2 = meshgrid(ns, ns, indexing='ij')
C_X_teo = 0.5 * (nn1 == nn2) - 0.25 * (nn1 == nn2 + 1) - 0.25 * (nn1 == nn2 - 1)
C_X_sim = cov(X, rowvar=False)

# Saída
# - Realizações
plt.figure()
for i in range(4):
    plt.subplot(2, 2, i + 1)
    plt.stem(ns, X[i])
    plt.xlabel("$n$")
    plt.ylabel("$X[n]$")
    plt.ylim(-1.2, 1.2)
    plt.title(f"Realização {i + 1}")
    plt.grid()
plt.tight_layout()
# - Função média
plt.figure()
plt.stem(ns, mu_X_teo, "m")
plt.stem(ns, mu_X_sim, "b")
plt.xlabel("$n$")
plt.ylabel("$\\mu_X[n]$")
plt.ylim(-1.2, 1.2)
plt.grid()
# - Função autocovariância
fig = plt.figure()
ax = fig.add_subplot(1, 2, 1)
ax.pcolormesh(nn1, nn2, C_X_teo, cmap='coolwarm', vmin=-0.5, vmax=0.5)
fig.colorbar(mappable=ax.collections[0], ax=ax, label="$C_X[n_1, n_2]$", shrink=0.6)
ax.set_xlabel("$n_1$")
ax.set_ylabel("$n_2$")
ax.set_title("Teoria")
ax.set_aspect("equal")
ax = fig.add_subplot(1, 2, 2)
ax.pcolormesh(nn1, nn2, C_X_sim, cmap='coolwarm', vmin=-0.5, vmax=0.5)
fig.colorbar(mappable=ax.collections[0], ax=ax, label="$C_X[n_1, n_2]$", shrink=0.6)
ax.set_xlabel("$n_1$")
ax.set_ylabel("$n_2$")
ax.set_title("Simulação")
ax.set_aspect("equal")
fig.tight_layout()
plt.show()
