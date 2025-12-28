import komm
import numpy as np
import streamlit as st

st.header("Probabilidade de erro -- $8$-PAM")

rng = np.random.default_rng(seed=42)
komm.global_rng.set(rng)

# Parâmetros
Rs = 250e3      # Taxa de símbolos [baud = símbolos/s]
Ts = 1 / Rs     # Intervalo de símbolo [s]
B = 0.5         # Amplitude de x(t) [V]
Ns = 1_000_000  # Número de símbolos
N0 = 800e-9     # PSD do ruído [V²/Hz]
M = 8           # Ordem da modulação

A = 1 / np.sqrt(Ts)
delta = 2*B/A

source = komm.DiscreteMemorylessSource(M)
pam = komm.PAMConstellation(order=M, delta=delta)
m_n = source.emit(Ns)
u_n = pam.indices_to_symbols(m_n)
w_n = rng.normal(scale=np.sqrt(N0/2), size=u_n.size)
v_n = u_n + w_n
m_n_hat = pam.closest_indices(v_n)
Ps_sim = np.mean(m_n != m_n_hat)
Ps_teo = 2 * (M-1) / M * komm.gaussian_q(np.sqrt(delta**2 / (2*N0)))

cols = st.columns(2)
with cols[0]:
    st.metric("SER teo", f"{Ps_teo:.2%}")
with cols[1]:
    st.metric("SER sim", f"{Ps_sim:.2%}")
