import matplotlib.pyplot as plt
from numpy import arange, empty, random

from pre import hist

# Parâmetros
N = 100000    # Número de realizações
dt = 0.05     # Passo do tempo
ts = arange(0.0, 1.0 + dt, dt)  # Eixo do tempo
Nt = ts.size  # Número de amostras temporais
t = 0.35      # Instante escolhido para a PDF de primeira ordem

# Experimento
X = empty((N, Nt))
for i in range(N):
    A = random.uniform(0, 1)
    B = random.uniform(0, 1)
    X[i] = (B - A)*ts + A

# Cálculos
dx = 0.02
xs = arange(-0.2, 1.2, dx)
tm = min(t, 1 - t)
pdf_X_teo = 1 / (tm * (1 - tm)) * (
    xs       * ((0 <= xs) & (xs < tm)) +
    tm       * ((tm <= xs) & (xs < 1 - tm)) +
    (1 - xs) * ((1 - tm <= xs) & (xs <= 1))
)
j = round((t - ts[0]) / dt)
pdf_X_sim = hist(X[:, j], xs)

# Saída
# - Realizações
plt.figure()
for i in range(200):
    plt.plot(ts, X[i], alpha=0.5)
plt.xlabel("$t$")
plt.ylabel("$X(t)$")
plt.title("Realizações de $X(t)$")
plt.grid()
# - PDF de primeira ordem
plt.figure()
plt.bar(xs, pdf_X_sim, width=0.8*dx, color="y")
plt.plot(xs, pdf_X_teo, linewidth=3, color="b")
plt.xlabel("$x$")
plt.ylabel(f"$f_{{X({t})}}(x)$")
plt.xlim(-0.2, 1.2)
plt.grid()
plt.show()
