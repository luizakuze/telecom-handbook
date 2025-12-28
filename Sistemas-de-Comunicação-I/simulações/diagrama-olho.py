import komm
import matplotlib.pyplot as plt
import numpy as np
import streamlit as st

st.title("Diagrama de olho")

rng = np.random.default_rng(seed=42)
komm.global_rng.set(rng)

# Parâmetros
Rs = 1.0        # Taxa de símbolos [baud]
Ts = 1 / Rs     # Intervalo de símbolo [s]
Ns = 400        # Número de símbolos de entrada
sps = 50        # Amostras por símbolo
dt = Ts / sps   # Passo do tempo [s]

rolloff = st.slider(
    label="Fator de rolloff ($\\alpha$):",
    min_value=0.0,
    max_value=1.0,
    value=0.5,
    step=0.01,
)

source = komm.DiscreteMemorylessSource(4)
u_n = np.array([-3, -1, 1, 3])[source.emit(Ns)]
pulse = komm.RaisedCosinePulse(rolloff)

# Geração do sinal PAM com o pulso equivalente
h_t = pulse.taps(samples_per_symbol=sps, span=(-16, 16))
u_t = komm.sampling_rate_expand(u_n, factor=sps) / dt
v_t = np.convolve(h_t, u_t) * dt

# Amostragem
v_n = komm.sampling_rate_compress(v_t, factor=sps)
v_n = v_n[16: Ns + 16]

tabs = st.tabs([
    "Pulso (tempo)",
    "Pulso (frequência)",
    "Sinal PAM",
    "Diagrama de olho",
])

with tabs[0]:  # Pulso (tempo)
    t = np.linspace(-16, 16, num=1000)
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.plot(t, pulse.waveform(t))
    ax.set_xlabel("$t / T_s$")
    ax.set_ylabel("$h(t)$")
    ax.set_ylim(-0.3, 1.1)
    ax.grid()
    st.pyplot(fig)

with tabs[1]:  # Pulso (frequência)
    f = np.linspace(-1.5, 1.5, num=1000)
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.plot(f, pulse.spectrum(f))
    ax.set_xlabel("$f / R_s$")
    ax.set_ylabel("$H(f)$")
    ax.set_ylim(-0.1, 1.1)
    ax.grid()
    st.pyplot(fig)

with tabs[2]:  # Sinal PAM
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.plot(np.arange(v_t.size)*dt, v_t)
    ax.plot(np.arange(Ns) + 16, v_n, "o")
    ax.set_xlabel("$t / T_s$")
    ax.set_ylabel("$v(t)$")
    ax.set_xlim(0, (Ns+32)*Ts)
    ax.set_ylim(-6, 6)
    ax.grid()
    st.pyplot(fig)

with tabs[3]:  # Diagrama de olho
    fig, ax = plt.subplots(1, 1, figsize=(10, 5))
    scope_width = 3  # Número de símbolos no "osciloscópio"
    Na = scope_width * sps
    t = np.linspace(0.0, scope_width, num=Na + 1)
    for i in range(len(u_n) // scope_width):
        n = np.arange(i*Na, (i+1)*Na + 1)
        ax.plot(t, v_t[n], "C0", alpha=0.25)
    ax.set_xlim(0.0, scope_width)
    ax.set_ylim(-6, 6)
    ax.set_xlabel("$t / T_s$")
    ax.set_ylabel("$v(t)$")
    ax.grid()
    st.pyplot(fig)
