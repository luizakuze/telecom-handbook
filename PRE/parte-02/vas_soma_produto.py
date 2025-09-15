from matplotlib import pyplot as plt
from numpy import array, random, set_printoptions

from pre import hist, hist2

# Parâmetros
N = 100000  # Número de realizações

# Experimento
U = random.randint(0, 3, N)
V = random.binomial(2, 0.5, N)
X = U + V
Y = U * V

# Cálculos
us = vs = [0, 1, 2]
pmf_U_teo = array([1, 1, 1]) / 3
pmf_U_sim = hist(U, us)
pmf_V_teo = array([1, 2, 1]) / 4
pmf_V_sim = hist(V, vs)
xs = ys = [0, 1, 2, 3, 4]
pmf_X_teo = array([1, 3, 4, 3, 1]) / 12
pmf_X_sim = hist(X, xs)
pmf_Y_teo = array([6, 2, 3, 0, 1]) / 12
pmf_Y_sim = hist(Y, ys)
pmf_XY_teo = array([[1, 0, 0, 0, 0],
                    [3, 0, 0, 0, 0],
                    [2, 2, 0, 0, 0],
                    [0, 0, 3, 0, 0],
                    [0, 0, 0, 0, 1]]) / 12
pmf_XY_sim = hist2(X, Y, xs, ys)


# Saída
plt.figure()
plt.subplot(2, 2, 1)
plt.bar(us, pmf_U_sim, color="y")
plt.stem(us, pmf_U_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.xlabel("$u$")
plt.ylabel("$p_U(u)$")
plt.grid()
plt.subplot(2, 2, 2)
plt.bar(vs, pmf_V_sim, color="y")
plt.stem(vs, pmf_V_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.xlabel("$v$")
plt.ylabel("$p_V(v)$")
plt.grid()
plt.subplot(2, 2, 3)
plt.bar(xs, pmf_X_sim, color="y")
plt.stem(xs, pmf_X_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.xlabel("$x$")
plt.ylabel("$p_X(x)$")
plt.grid()
plt.subplot(2, 2, 4)
plt.bar(ys, pmf_Y_sim, color="y")
plt.stem(ys, pmf_Y_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.xlabel("$y$")
plt.ylabel("$p_Y(y)$")
plt.grid()
plt.tight_layout()
set_printoptions(precision=4, suppress=True, floatmode="fixed")
print(f"Teo: p_XY =\n{pmf_XY_teo}")
print(f"Sim: p_XY =\n{pmf_XY_sim}")
plt.show()
