import matplotlib.pyplot as plt
from numpy import (arange, array, cov, empty, mean, random, set_printoptions,
                   sort)

from pre import hist

# Parâmetros
N = 1000000  # Número de realizações

# Experimento
U = random.uniform(0, 1, (3, N))
X = sort(U, axis=0)

# Cálculos
dx = 0.02
xs = arange(-0.2, 1.2, dx)
pdf_U_teo = empty((3, xs.size))
for i in range(3):
    pdf_U_teo[i] = [1 if 0 <= u <= 1 else 0 for u in xs]
pdf_X_teo = empty((3, xs.size))
pdf_X_teo[0] = [3 * (1 - x)**2  if 0 <= x <= 1 else 0 for x in xs]
pdf_X_teo[1] = [6 * y * (1 - y) if 0 <= y <= 1 else 0 for y in xs]
pdf_X_teo[2] = [3 * z**2        if 0 <= z <= 1 else 0 for z in xs]
pdf_U_sim = [hist(U[i], xs) for i in range(3)]
pdf_X_sim = [hist(X[i], xs) for i in range(3)]
ev_U_teo = 1/2 * array([1, 1, 1])
ev_U_sim = mean(U, axis=1)
cov_U_teo = 1/12 * array([[1, 0, 0], [0, 1, 0], [0, 0, 1]])
cov_U_sim = cov(U)
ev_X_teo = 1/4 * array([1, 2, 3])
ev_X_sim = mean(X, axis=1)
cov_X_teo = 1/80 * array([[3, 2, 1], [2, 4, 2], [1, 2, 3]])
cov_X_sim = cov(X)

# Saída
plt.figure()
for i in range(3):
    plt.subplot(2, 3, i+1)
    plt.bar(xs, pdf_U_sim[i], width=0.8*dx, color="y")
    plt.plot(xs, pdf_U_teo[i], linewidth=3, color="b")
    plt.xlabel("$u$")
    plt.ylabel(f"$f_{{U_{i+1}}}(u)$")
    plt.grid()
    plt.subplot(2, 3, i+4)
    plt.bar(xs, pdf_X_sim[i], width=0.8*dx, color="y")
    plt.plot(xs, pdf_X_teo[i], linewidth=3, color="b")
    plt.xlabel("$x$")
    plt.ylabel(f"$f_{{X_{i+1}}}(x)$")
    plt.grid()
plt.tight_layout()
set_printoptions(precision=4, suppress=True, floatmode="fixed")
print(f"Teo: E[U] = {ev_U_teo}")
print(f"Sim: E[U] = {ev_U_sim}")
print(f"Teo: cov[U] =\n{cov_U_teo}")
print(f"Sim: cov[U] =\n{cov_U_sim}")
print(f"Teo: E[X] = {ev_X_teo}")
print(f"Sim: E[X] = {ev_X_sim}")
print(f"Teo: cov[X] =\n{cov_X_teo}")
print(f"Sim: cov[X] =\n{cov_X_sim}")
plt.show()
