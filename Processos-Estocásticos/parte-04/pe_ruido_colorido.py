import matplotlib.pyplot as plt
from numpy import abs, arange, cov, diagonal, mean, random, sinc, sqrt
from numpy.fft import fft, fftfreq, ifft

# Parâmetros
N = 1000    # Número de realizações
η = 20.0    # Densidade espectral de potência de X(t)
f0 = 5.0    # Frequência de corte do filtro passa-baixa
dt = 0.002  # Passo do tempo
dur = 10.0  # Duração do experimento
ts = arange(0.0, dur, dt)       # Eixo do tempo
Nt = ts.size                    # Número de amostras temporais
fs = fftfreq(Nt, d=dt)          # Eixo de frequências
τs = arange(-dur/2, dur/2, dt)  # Eixo do dos atrasos

# Experimento
W_t = random.normal(loc=0.0, scale=sqrt(η), size=(N, Nt))  # Ruído branco gaussiano
W_f = fft(W_t)               # Espectro do ruído branco
X_f = W_f * (abs(fs) <= f0)  # Filtragem passa-baixa
X_t = ifft(X_f).real         # Sinal filtrado no domínio do tempo

# Cálculos
C_X_teo = 2*η*f0*sinc(2*f0*τs)
C_X_mat = cov(X_t, rowvar=False)
C_X_sim = [mean(diagonal(C_X_mat, ℓ)) / dt for ℓ in range(-Nt//2 + 1, Nt//2 + 1)]

# Saída
# - Realizações
plt.figure()
for i in range(4):
    plt.subplot(2, 2, i + 1)
    plt.plot(ts, X_t[i])
    plt.xlabel("$t$")
    plt.ylabel("$X(t)$")
    plt.xlim(0, 5)
    plt.title(f"Realização {i + 1}")
    plt.grid()
plt.tight_layout()
# - Função autocovariância
plt.figure()
plt.plot(τs, C_X_teo, label="Teoria")
plt.plot(τs, C_X_sim, label="Simulação")
plt.xlabel("$\\tau$")
plt.ylabel("$C_X(\\tau)$")
plt.xlim(-1, 1)
plt.legend()
plt.grid()
plt.show()
