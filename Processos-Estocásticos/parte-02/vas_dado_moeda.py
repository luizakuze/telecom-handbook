from matplotlib import pyplot as plt
from numpy import array, cov, random, set_printoptions, sqrt, var, zeros

from pre import hist, hist2

# Parâmetros
N = 100000  # Número de realizações

# Experimento
X = random.randint(1, 4, N)
Y = zeros(N, dtype=int)
for i in range(N):
    Y[i] = random.binomial(X[i], 0.5)

# Cálculos
xs = [1, 2, 3]
ys = [0, 1, 2, 3]
pmf_XY_teo = array([[ 1/6,  1/6,    0,    0],
                    [1/12, 2/12, 1/12,    0],
                    [1/24, 3/24, 3/24, 1/24]])
pmf_XY_sim = hist2(X, Y, xs, ys)
pmf_X_teo = [1/3, 1/3, 1/3]
pmf_X_sim = hist(X, xs)
pmf_Y_teo = [7/24, 11/24, 5/24, 1/24]
pmf_Y_sim = hist(Y, ys)
cov_XY_teo = 1/3
cov_XY_sim = cov(X, Y)[0, 1]
rho_XY_teo = 1/2
rho_XY_sim = cov_XY_sim / sqrt(var(X) * var(Y))

# Saída
plt.subplot(1, 2, 1)
plt.bar(xs, pmf_X_sim, color="y")
plt.stem(xs, pmf_X_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$p_X(x)$")
plt.subplot(1, 2, 2)
plt.bar(ys, pmf_Y_sim, color="y")
plt.stem(ys, pmf_Y_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.grid()
plt.xlabel("$y$")
plt.ylabel("$p_Y(y)$")
plt.tight_layout()
set_printoptions(precision=4, suppress=True, floatmode="fixed")
print(f"Teo: p_XY =\n{pmf_XY_teo}")
print(f"Sim: p_XY =\n{pmf_XY_sim}")
print(f"Teo: cov[X, Y] = {cov_XY_teo:.4f}")
print(f"Sim: cov[X, Y] = {cov_XY_sim:.4f}")
print(f"Teo: ρ_XY = {rho_XY_teo:.4f}")
print(f"Sim: ρ_XY = {rho_XY_sim:.4f}")
plt.show()
