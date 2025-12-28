import komm
import matplotlib.pyplot as plt
import numpy as np
import streamlit as st

st.title("PCM")

# Parâmetros
fa = 120.0      # Taxa de amostragem [amostras/s]
Ta = 1 / fa     # Intervalo de amostragem [s]
dt = 1e-6       # Passo do "tempo contínuo" [s]
L = 8           # Número de níveis de quantização
Δ = 1.0         # Passo de quantização [V]

# Sinal
ts = np.arange(0.0, 0.2, step=dt)
x_t = 3*np.sin(2*np.pi*10*ts) - 2*np.cos(2*np.pi*20*ts)

# Amostragem
x_n = komm.sampling_rate_compress(x_t, int(Ta / dt))
ns = np.arange(x_n.size)

# Quantização
quant = komm.UniformQuantizer.mid_riser(num_levels=L, step=Δ)
d_n = quant.digitize(x_n)
y_n = quant.quantize(x_n)

# Codificação para bits
labeling = komm.NaturalLabeling(num_bits=3)
bits = labeling.indices_to_bits(d_n)

tabs = st.tabs(["Curva entrada x saída", "Sinais", "Tabela"])

with tabs[0]:
    entrada = np.linspace(-6, 6, num=10000)
    saida = quant.quantize(entrada)
    fig, ax = plt.subplots()
    ax.plot(entrada, saida)
    ax.set_xlabel("$x$")
    ax.set_ylabel("$y$")
    ax.set_xticks(np.arange(-6, 7, 1))
    ax.set_yticks(np.arange(-5, 6, 1))
    ax.grid()
    st.pyplot(fig)

with tabs[1]:
    fig, ax = plt.subplots()
    ax.plot(ts, x_t, "C0", label="x(t)")
    ax.plot(ns * Ta, x_n, "C2o", label="$x[n]$")
    ax.plot(ns * Ta, y_n, "C1o", label="$y[n]$")
    ax.grid()
    ax.set_xlim(0, 0.2)
    ax.set_ylim(-8, 8)
    ax.set_xlabel("$t$ [s]")
    ax.legend()
    st.pyplot(fig)

with tabs[2]:
    st.write(f"Bits: `{bits}`")
    st.table({
        "$x[n]$": x_n,
        "$d[n]$": d_n,
        "bits": [labeling.indices_to_bits(d) for d in d_n],
        "$y[n]$": y_n,
    })
