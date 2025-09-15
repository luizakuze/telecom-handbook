import matplotlib.pyplot as plt
from numpy import arange, array, isin, mean, random

from pre import hist

# Parâmetros
N = 100000  # Número de realizações

# Experimento
D1 = random.randint(1, 7, N)
D2 = random.randint(1, 7, N)
X = D1 + D2

# Cálculos
xs = arange(2, 13)
pmf_X_teo = array([1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1]) / 36
pmf_X_sim = hist(X, xs)
pr_primo_teo = 15/36
pr_primo_sim = mean(isin(X, [2, 3, 5, 7, 11]))

# Saída
plt.figure()
plt.bar(xs, pmf_X_sim, color="y")
plt.stem(xs, pmf_X_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$p_X(x)$")
print(f"Teo: Pr[X primo] = {pr_primo_teo:%}")
print(f"Sim: Pr[X primo] = {pr_primo_sim:%}")
plt.show()
