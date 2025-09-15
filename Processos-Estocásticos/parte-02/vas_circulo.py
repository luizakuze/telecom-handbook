from matplotlib import pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from numpy import arange, empty, meshgrid, pi, random, sqrt, zeros

from pre import hist, hist2

# Parâmetros
N = 100000  # Número de realizações

# Experimento
X = empty(N)
Y = empty(N)
for i in range(N):
    while True:
        X[i] = random.uniform(-1, 1)
        Y[i] = random.uniform(-1, 1)
        if X[i]**2 + Y[i]**2 <= 1:  # Checa se está dentro do círculo
            break

# Cálculos
dx = 0.05
xs = arange(-1.2, 1.2, dx)
ys = arange(-1.2, 1.2, dx)
xx, yy = meshgrid(xs, ys, indexing="ij")
pdf_XY_teo = (1/pi) * (xx**2 + yy**2 <= 1)
pdf_XY_sim = hist2(X, Y, xs, ys)
pdf_X_teo = [(2/pi) * sqrt(1 - x**2) if -1 <= x <= 1 else 0 for x in xs]
pdf_X_sim = hist(X, xs)
eps = 0.02
ys0 = [0, 0.5, 0.8, 0.95]
pdf_X_cond_Y_teo = zeros((len(ys0), len(xs)))
pdf_X_cond_Y_sim = zeros((len(ys0), len(xs)))
for i, y in enumerate(ys0):
    pdf_X_cond_Y_teo[i] = [0.5/sqrt(1 - y**2) if abs(x) <= sqrt(1 - y**2) else 0 for x in xs]
    pdf_X_cond_Y_sim[i] = hist(X[abs(Y - y) <= eps], xs)

# Saída
plt.figure()
plt.scatter(X[:10000], Y[:10000], s=0.5)
plt.axis("square")
plt.xlabel("$x$")
plt.ylabel("$y$")
fig = plt.figure()
ax: Axes3D = fig.add_subplot(1, 2, 1, projection="3d")  # type: ignore
ax.plot_surface(xx, yy, pdf_XY_teo, cmap="coolwarm")
ax.set_xlabel("$x$")
ax.set_ylabel("$y$")
ax.set_zlabel("$f_{X, Y}(x, y)$")
ax.set_title("Teoria")
ax: Axes3D = fig.add_subplot(1, 2, 2, projection="3d")  # type: ignore
ax.plot_surface(xx, yy, pdf_XY_sim, cmap="coolwarm")
ax.set_xlabel("$x$")
ax.set_ylabel("$y$")
ax.set_zlabel("$f_{X, Y}(x, y)$")
ax.set_title("Simulação")
plt.figure()
plt.bar(xs, pdf_X_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_X_teo, linewidth=3, color="b")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$f_X(x)$")
plt.figure()
for i, y in enumerate(ys0):
    plt.subplot(2, 2, i + 1)
    plt.bar(xs, pdf_X_cond_Y_sim[i], width=0.8*dx, color="y")
    plt.plot(xs, pdf_X_cond_Y_teo[i], linewidth=3, color="b")
    plt.xlabel("$x$")
    plt.ylabel(f"$f_X(x \\mid Y = {y})$")
    plt.grid()
plt.tight_layout()
plt.show()
