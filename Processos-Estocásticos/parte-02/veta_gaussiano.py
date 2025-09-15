import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from numpy import arange, exp, mean, meshgrid, pi, random, sqrt

from pre import hist, hist2, phi

# Parâmetros
N = 100000       # Número de realizações
mu = [0, 0, 0]   # Vetor média
C = [[3, 3, 0],  # Matriz covariância
     [3, 5, 0],
     [0, 0, 6]]

# Experimento
vet_X = random.multivariate_normal(mu, C, N)
X = vet_X[:, 0]
Y = vet_X[:, 1]
Z = vet_X[:, 2]
W = X + 2*Y - Z + 5
Xcond_c = X[(0.9 < Y) & (Y < 1.1)]
Xcond_d = X[(2.9 < Z) & (Z < 3.1)]

# Cálculos

# (a)
dx = 0.5; xs = arange(-9, 9, dx)
dy = 0.5; ys = arange(-9, 9, dy)
xx, yy = meshgrid(xs, ys, indexing="ij")
pdf_XY_teo = 1 / sqrt((2*pi)**2 * 6) * exp(-(5*xx**2 - 6*xx*yy + 3*yy**2) / 12)
pdf_XY_sim = hist2(X, Y, xs, ys)

# (b)
dw = 0.5; ws = arange(-20, 30, dw)
pdf_W_teo = 1 / sqrt(2*pi*41) * exp(-(ws - 5)**2 / (2*41))
pdf_W_sim = hist(W, ws)

# (c)
pdf_X_teo = 1 / sqrt(2*pi*3) * exp(-xs**2 / (2*3))
pdf_X_sim = hist(X, xs)
pdf_Xcond_teo =  1 / sqrt(2*pi*1.2) * exp(-(xs - 0.6)**2 / (2*1.2))
pdf_Xcond_sim = hist(Xcond_c, xs)

# (d)
pr_teo = phi(1 / sqrt(3)) - phi(0)
pr_sim = mean((0 <= Xcond_d) & (Xcond_d <= 1))

# Saída

# (a)
fig = plt.figure()
ax: Axes3D = fig.add_subplot(1, 2, 1, projection="3d")  # type: ignore
ax.plot_surface(xx, yy, pdf_XY_teo, cmap="coolwarm")
ax.set_xlabel("$x$")
ax.set_ylabel("$y$")
ax.set_zlabel("$f_{X, Y}(x, y)$")
ax.set_title("Teoria")
ax = fig.add_subplot(1, 2, 2, projection="3d")  # type: ignore
ax.plot_surface(xx, yy, pdf_XY_sim, cmap="coolwarm")
ax.set_xlabel("$x$")
ax.set_ylabel("$y$")
ax.set_zlabel("$f_{X, Y}(x, y)$")
ax.set_title("Simulação")

# (b)
plt.figure()
plt.bar(ws, pdf_W_sim, width=0.8*dw, color="y")
plt.plot(ws, pdf_W_teo, linewidth=3, color="b")
plt.xlabel("$w$")
plt.ylabel(f"$f_W(w)$")
plt.xlim(-20, 30)
plt.grid()

# (c)
plt.figure()
plt.subplot(1, 2, 1)
plt.title("A priori")
plt.bar(xs, pdf_X_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_X_teo, linewidth=3, color="b")
plt.xlabel("$x$")
plt.ylabel(f"$f_X(x)$")
plt.xlim(-9, 9)
plt.ylim(0 ,0.4)
plt.grid()
plt.subplot(1, 2, 2)
plt.title("A posteriori")
plt.bar(xs, pdf_Xcond_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_Xcond_teo, linewidth=3, color="b")
plt.xlabel("$x$")
plt.ylabel(f"$f_X(x \\mid Y=1)$")
plt.xlim(-9, 9)
plt.ylim(0 ,0.4)
plt.grid()

# (d)
print(f"Teo: Pr[0 ≤ X ≤ 1 | Z = 3] = {pr_teo:%}")
print(f"Sim: Pr[0 ≤ X ≤ 1 | Z = 3] = {pr_sim:%}")

plt.show()
