import matplotlib.pyplot as plt
from numpy import arange, mean, random, sum

from pre import hist

# Parâmetros
N = 100000  # Número de realizações
p = 2/3     # Probabilidade de sucesso

# Experimento
X = random.geometric(p, N)

# Cálculos
xs = arange(1, round(8 / p) + 1)
pmf_X_teo = p * (1 - p) ** (xs - 1)
pmf_X_sim = hist(X, xs)
pr_X_le_3_teo = sum(pmf_X_teo[:3])
pr_X_le_3_sim = mean(X <= 3)
ev_X_teo = 1 / p
ev_X_sim = mean(X)

# Saída
plt.bar(xs, pmf_X_sim, color="y")
plt.stem(xs, pmf_X_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$p_X(x)$")
print(f"Teo: Pr[X <= 3] = {pr_X_le_3_teo:%}")
print(f"Sim: Pr[X <= 3] = {pr_X_le_3_sim:%}")
print(f"Teo: E[X] = {ev_X_teo:g}")
print(f"Sim: E[X] = {ev_X_sim:g}")
plt.show()
