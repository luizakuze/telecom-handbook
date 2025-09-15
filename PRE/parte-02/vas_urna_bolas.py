from matplotlib import pyplot as plt
from numpy import array, empty, random, set_printoptions, sum, zeros

from pre import hist, hist2

# Parâmetros
N = 50000  # Número de realizações

# Experimento
X = zeros(N, dtype=int)
Y = zeros(N, dtype=int)
for i in range(N):
    B = random.choice(["R", "R", "G", "B"], size=2, replace=False)
    X[i] = sum(B == "R")
    Y[i] = sum(B == "G")

# Cálculos
xs = [0, 1, 2]
ys = [0, 1]
pmf_XY_teo = array([[0, 1/6], [1/3, 1/3], [1/6, 0]])
pmf_XY_sim = hist2(X, Y, xs, ys)
pmf_X_teo = array([1/6, 2/3, 1/6])
pmf_X_sim = hist(X, xs)
pmf_Y_teo = array([1/2, 1/2])
pmf_Y_sim = hist(Y, ys)

pmf_Y_cond_X_teo = array([[0, 1], [1/2, 1/2], [1, 0]])
pmf_Y_cond_X_sim = empty((3, 2))
for i, x in enumerate(xs):
    pmf_Y_cond_X_sim[i] = hist(Y[X == x], ys)

# Saída
plt.subplot(2, 3, 2)
plt.bar(ys, pmf_Y_sim, color="y")
plt.stem(ys, pmf_Y_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.grid()
plt.xlabel("$y$")
plt.ylabel("$p_Y(y)$")
for i, x in enumerate(xs):
    plt.subplot(2, 3, i + 4)
    plt.bar(ys, pmf_Y_cond_X_sim[i], color="y")
    plt.stem(ys, pmf_Y_cond_X_teo[i], linefmt="b-", markerfmt="bo", basefmt="b-")
    plt.grid()
    plt.xlabel("$y$")
    plt.ylabel(f"$p_Y(y \\mid X={x})$")
plt.tight_layout()
set_printoptions(precision=4, suppress=True, floatmode="fixed")
print(f"Teo: p_XY =\n{pmf_XY_teo}")
print(f"Sim: p_XY =\n{pmf_XY_sim}")
plt.show()
