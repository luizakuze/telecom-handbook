from matplotlib import pyplot as plt
from numpy import cov, random, set_printoptions, sqrt, var, zeros

# Parâmetros
N = 100000  # Número de realizações

# Experimento
X = random.uniform(0, 1, N)
Y = zeros(N)
for i in range(N):
    Y[i] = random.uniform(0, X[i])

# Cálculos
cov_XY_teo = 1/24
cov_XY_sim = cov(X, Y)[0, 1]
rho_XY_teo = sqrt(21) / 7
rho_XY_sim = cov_XY_sim / sqrt(var(X) * var(Y))

# Saída
plt.figure()
plt.scatter(X[:10000], Y[:10000], s=0.5)
plt.axis("square")
plt.xlabel("$x$")
plt.ylabel("$y$")
set_printoptions(precision=4)
print(f"Teo: cov[X, Y] = {cov_XY_teo:g}")
print(f"Sim: cov[X, Y] = {cov_XY_sim:g}")
print(f"Teo: ρ_{{X, Y}} = {rho_XY_teo:g}")
print(f"Sim: ρ_{{X, Y}} = {rho_XY_sim:g}")
plt.show()
