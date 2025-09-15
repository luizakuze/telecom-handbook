import matplotlib.pyplot as plt
from numpy import arange, exp, mean, pi, random, sqrt

from pre import hist, phi

# Parâmetros
N = 100000  # Número de realizações
mu = 5      # Média
sigma = 4   # Desvio padrão

# Experimento
X = random.normal(mu, sigma, N)

# Cálculos
dx = 0.5
xs = arange(mu - 4*sigma, mu + 4*sigma, dx)
pdf_X_teo = 1 / sqrt(2 * pi * sigma**2) * exp(-((xs - mu) ** 2) / (2 * sigma**2))
pdf_X_sim = hist(X, xs)
pr_7_le_x_le_12_teo = phi((12 - mu) / sigma) - phi((7 - mu) / sigma)
pr_7_le_x_le_12_sim = mean((7 <= X) & (X <= 12))

# Saída
plt.figure()
plt.bar(xs, pdf_X_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_X_teo, linewidth=3, color="b")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$f_X(x)$")
print(f"Teo: Pr[7 ≤ X ≤ 12] = {pr_7_le_x_le_12_teo:%}")
print(f"Sim: Pr[7 ≤ X ≤ 12] = {pr_7_le_x_le_12_sim:%}")
plt.show()
