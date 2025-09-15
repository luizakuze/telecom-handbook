import matplotlib.pyplot as plt
from numpy import arange, array, empty, random, set_printoptions

from pre import hist, hist2

# Parâmetros
N = 10000          # Número de realizações
dt = 0.5           # Passo do tempo
ts = arange(-5.0, 20.0 + dt, dt)  # Eixo do tempo
Nt = ts.size       # Número de amostras temporais
t = 8.5            # Instante escolhido para a PMF de primeira ordem
t1, t2 = 3.0, 9.5  # Instantes escolhidos para a PMF de segunda ordem

# Experimento
X = empty((N, Nt))
for i in range(N):
    A = 2 * random.randint(0, 2) - 1
    B = 2 * random.randint(0, 2) - 1
    X[i] = A * ((0 <= ts) & (ts < 10)) + B * ((5 <= ts) & (ts < 15))

# Cálculos
xs = array([-2, -1, 0, 1, 2])
# - PMF de primeira ordem
if 0 <= t < 5 or 10 <= t < 15:
    pmf_X_teo = 0.5 * (xs == -1) + 0.5 * (xs == 1)
elif 5 <= t < 10:
    pmf_X_teo = 0.25 * (xs == -2) + 0.5 * (xs == 0) + 0.25 * (xs == 2)
else:
    pmf_X_teo = 1 * (xs == 0)
j = round((t - ts[0]) / dt)
pmf1_X_sim = hist(X[:, j], xs)
# - PMF de segunda ordem
j1 = round((t1 - ts[0]) / dt)
j2 = round((t2 - ts[0]) / dt)
# pmf2_X_teo = ver slides
pmf2_X_sim = hist2(X[:, j1], X[:, j2], xs, xs)

# Saída
# - Realizações
plt.figure()
for i in range(200):
    plt.step(ts, X[i], alpha=0.5, where="post")
plt.xlabel("$t$")
plt.ylabel("$X(t)$")
plt.title("Realizações de $X(t)$")
plt.grid()
# - PMF de primeira ordem
plt.figure()
plt.bar(xs, pmf1_X_sim, color="y")
plt.stem(xs, pmf_X_teo, linefmt="b-", markerfmt="bo", basefmt="b-")
plt.grid()
plt.xlabel("$x$")
plt.ylabel(f"$p_{{X({t})}}(x)$")
# - PMF de segunda ordem
set_printoptions(precision=4, suppress=True, floatmode="fixed")
print(f"Sim: p_{{X({t1}), X({t2})}} =\n{pmf2_X_sim}")
plt.show()
