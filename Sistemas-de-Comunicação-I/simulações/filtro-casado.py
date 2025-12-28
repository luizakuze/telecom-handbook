import komm
import matplotlib.pyplot as plt
import numpy as np
import streamlit as st

st.title("Filtro casado")

# Parâmetros
Rs = 50e3               # Taxa de símbolos [símbolos/s = baud]
Ts = 1 / Rs             # Intervalo de símbolo [s]
sps = 100               # Amostras por símbolo
dt = Ts / sps           # Passo de simulação [s]
A = 1 / np.sqrt(Ts)     # Amplitude de p(t)

pulse = komm.RectangularPulse()
p_t = A * pulse.taps(sps)   # Pulso de transmissão
q_t = np.flip(p_t)          # Pulso de recepção (casado)

# Sistema
u_n = np.array([-1.0, +1.0, +1.0, -3.0])    # Sequência de entrada
Ns = u_n.size                               # Número de símbolos de entrada
u_t = komm.sampling_rate_expand(u_n, factor=sps) / dt
x_t = np.convolve(p_t, u_t) * dt            # Sinal PAM transmitido
y_t = x_t                                   # Sem ruído
v_t = np.convolve(q_t, y_t) * dt            # Saída do filtro de RX
v_n = komm.sampling_rate_compress(v_t, factor=sps)
v_n = v_n[1 : Ns + 1]   # Compensação do atraso

tabs = st.tabs(["Pulso equivalente", "Sinais"])

with tabs[0]:
    t = np.linspace(0, Ts, num=1000)
    h_t = np.convolve(p_t, q_t) * dt
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.plot(np.arange(h_t.size) * dt / 1e-6, h_t)
    ax.set_xlabel("$t$ [µs]")
    ax.set_ylabel("$h(t)$")
    ax.grid()
    st.pyplot(fig)

with tabs[1]:
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.plot(np.arange(x_t.size) * dt / 1e-6, x_t / A, "C0", label="$x(t)$")
    ax.plot(np.arange(v_t.size) * dt / 1e-6, v_t, "C2", label="$v(t)$")
    ax.plot((np.arange(Ns) + 1) * Ts / 1e-6, v_n, "C2o", label="$v[n]$")
    ax.set_xlabel("$t$ [µs]")
    ax.grid()
    ax.set_ylim(-4, 4)
    ax.legend()
    st.pyplot(fig)
