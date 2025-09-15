import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from numpy import arange, cos, cov, empty, mean, meshgrid, ones, pi, random

# Parâmetros
N = 10000     # Número de realizações
dt = 0.02     # Passo do tempo
ts = arange(-1.0, 1.0 + dt, dt)  # Eixo do tempo
Nt = ts.size  # Número de amostras temporais
a = 1.0       # Amplitude da senoide
b = 2.0       # Valor DC
f0 = 1.0      # Frequência da senoide

# Experimento
X = empty((N, Nt))
for i in range(N):
    THETA = random.uniform(-pi, pi)
    X[i] = a * cos(2*pi*f0*ts - THETA) + b

# Cálculos
mu_X_teo = b * ones(Nt)
mu_X_sim = mean(X, axis=0)
tt1, tt2 = meshgrid(ts, ts, indexing='ij')
CX_teo = 0.5 * a**2 * cos(2*pi*f0*(tt2 - tt1))
CX_sim = cov(X, rowvar=False)

# Saída
# - Realizações
plt.figure()
for i in range(100):
    plt.plot(ts, X[i], alpha=0.5)
plt.xlabel("$t$")
plt.ylabel("$X(t)$")
plt.ylim(-0.2, 3.2)
plt.title("Realizações de $X(t)$")
plt.grid()
# - Função média
plt.figure()
plt.plot(ts, mu_X_teo, "m", linewidth=8, alpha=0.5)
plt.plot(ts, mu_X_sim, "b", linewidth=2)
plt.xlabel("$t$")
plt.ylabel("$\\mu_X(t)$")
plt.ylim(-0.2, 3.2)
plt.grid()
# - Função autocovariância
fig = plt.figure()
ax: Axes3D
ax = fig.add_subplot(1, 2, 1, projection="3d")  # type: ignore
ax.plot_surface(tt1, tt2, CX_teo, cmap='coolwarm')
ax.set_xlabel("$t_1$")
ax.set_ylabel("$t_2$")
ax.set_zlabel("$C_X(t_1, t_2)$")
ax.set_title("Teoria")
ax = fig.add_subplot(1, 2, 2, projection="3d")  # type: ignore
ax.plot_surface(tt1, tt2, CX_sim, cmap='coolwarm')
ax.set_xlabel("$t_1$")
ax.set_ylabel("$t_2$")
ax.set_zlabel("$C_X(t_1, t_2)$")
ax.set_title("Simulação")
plt.show()
