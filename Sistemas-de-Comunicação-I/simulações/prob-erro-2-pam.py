import komm
import matplotlib.pyplot as plt
import numpy as np
import streamlit as st

st.header("Probabilidade de erro -- $2$-PAM")

rng = np.random.default_rng(seed=42)
komm.global_rng.set(rng)

# Parâmetros
Rs = 10e3       # Taxa de símbolos [baud = símbolos/s]
Ts = 1 / Rs     # Intervalo de símbolo [s]
sps = 50        # Amostras por símbolo
dt = Ts / sps   # Passo de simulação [s]
B = 2.0         # Amplitude de x(t) [V]
Ns = 10000      # Número de símbolos
N0 = 200e-6     # PSD do ruído [V²/Hz]

A = 1 / np.sqrt(Ts)
delta = 2*B/A

pulse = komm.RectangularPulse(width=1)  # NRZ
source = komm.DiscreteMemorylessSource(2)
pam = komm.PAMConstellation(order=2, delta=delta)

m_n = source.emit(Ns)
u_n = pam.indices_to_symbols(m_n)


# Simulação em tempo contínuo
p_t = A * pulse.taps(sps)   # Filtro de TX
q_t = np.flip(p_t)          # Filtro de RX (casado)
u_t = komm.sampling_rate_expand(u_n, factor=sps) / dt
x_t = np.convolve(p_t, u_t) * dt
z_t = rng.normal(scale=np.sqrt((N0/2) / dt), size=x_t.size)
y_t = x_t + z_t
v_t = np.convolve(y_t, q_t) * dt
v_n = komm.sampling_rate_compress(v_t, factor=sps)
v_n = v_n[1 : Ns+1]
m_n_hat = pam.closest_indices(v_n)
Pb_sim_ct = np.mean(m_n != m_n_hat)

# Simulação em tempo discreto
w_n = rng.normal(scale=np.sqrt(N0/2), size=u_n.size)
v_n = u_n + w_n
m_n_hat = pam.closest_indices(v_n)
Pb_sim_dt = np.mean(m_n != m_n_hat)

# Teórico
Pb_teo = komm.gaussian_q(np.sqrt(delta**2 / (2*N0)))

cols = st.columns(3)
with cols[0]:
    st.metric("BER teo", f"{Pb_teo:.2%}")
with cols[1]:
    st.metric("BER sim (ct)", f"{Pb_sim_ct:.2%}")
with cols[2]:
    st.metric("BER sim (dt)", f"{Pb_sim_dt:.2%}")

fig, ax = plt.subplots(figsize=(10, 5))
ax.plot(np.arange(x_t.size)*dt / 1e-3, x_t, label="$x(t)$")
ax.plot(np.arange(y_t.size)*dt / 1e-3, y_t, label="$y(t)$", alpha=0.5)
ax.set_xlim(0, 16*Ts / 1e-3)
ax.set_xlabel("$t$ [ms]")
ax.legend()
ax.grid()
st.pyplot(fig)
