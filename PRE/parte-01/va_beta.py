import matplotlib.pyplot as plt
from numpy import arange, mean, random, sqrt

from pre import hist

# Parâmetros
N = 100000  # Número de realizações

# Experimento
X = random.rand(N)
Y = X**2

# Cálculos
dx = 0.01
xs = arange(-0.2, 1.2, dx)
dy = 0.01
ys = arange(-0.2, 1.2, dy)
pdf_X_teo = [1 if 0 <= x <= 1 else 0 for x in xs]
pdf_X_sim = hist(X, xs)
pdf_Y_teo = [0.5 / sqrt(y) if 0 <= y <= 1 else 0 for y in ys]
pdf_Y_sim = hist(Y, ys)
ev_X_teo = 1/2
ev_X_sim = mean(X)
ev_Y_teo = 1/3
ev_Y_sim = mean(Y)

# Saída
plt.figure()
plt.bar(xs, pdf_X_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_X_teo, linewidth=3, color="b")
plt.grid()
plt.xlabel("$x$")
plt.ylabel("$f_X(x)$")
plt.figure()
plt.bar(ys, pdf_Y_sim, width=0.8*dy, color="y")
plt.plot(ys, pdf_Y_teo, linewidth=3, color="b")
plt.grid()
plt.xlabel("$y$")
plt.ylabel("$f_Y(y)$")
plt.ylim(0, 4)
print(f"Teo: E[X] = {ev_X_teo:g}")
print(f"Sim: E[X] = {ev_X_sim:g}")
print(f"Teo: E[Y] = {ev_Y_teo:g}")
print(f"Sim: E[Y] = {ev_Y_sim:g}")
plt.show()
