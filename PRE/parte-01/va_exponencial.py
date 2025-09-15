import matplotlib.pyplot as plt
from numpy import arange, exp, mean, random

from pre import hist

# Parâmetros
N = 100000  # Número de realizações
beta = 10   # Potência média [mW]
x0 = 5      # Limiar de potência [mW]

# Experimento
X = random.exponential(beta, N)

# Cálculos
dx = 0.1 * beta
xs = arange(-beta, 10*beta, dx)
pdf_X_teo = (1 / beta) * exp(-xs / beta) * (xs >= 0)
pdf_X_sim = hist(X, xs)
pr_X_lt_10_sim = mean(X < x0)
pr_X_lt_10_teo = 1 - exp(-x0 / beta)
ev_X_sim = mean(X)
ev_X_teo = beta

# Saída
plt.figure()
plt.bar(xs, pdf_X_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_X_teo, linewidth=3, color="b")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$f_X(x)$")
plt.xlim(-beta, 7*beta)
print(f"Teo: Pr[X < {x0}] = {pr_X_lt_10_teo:%}")
print(f"Sim: Pr[X < {x0}] = {pr_X_lt_10_sim:%}")
print(f"Teo: E[X] = {ev_X_teo:g}")
print(f"Sim: E[X] = {ev_X_sim:g}")
plt.show()
