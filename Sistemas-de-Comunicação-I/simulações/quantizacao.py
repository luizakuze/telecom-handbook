from functools import partial

import matplotlib.pyplot as plt
import numpy as np
import streamlit as st
from scipy import optimize, stats

st.title("Quantização baseada em pdf")

def gaussian_mixture(x):
    return 0.25 * stats.norm.pdf(x, loc=-3, scale=0.5) + 0.75 * stats.norm.pdf(x, loc=2, scale=0.8)

pdf_options = {
    "Uniform": partial(stats.uniform.pdf, loc=-np.sqrt(3), scale=2*np.sqrt(3)),
    "Gaussian": partial(stats.norm.pdf, loc=0, scale=1),
    "Laplacian": partial(stats.laplace.pdf, loc=0, scale=1/np.sqrt(2)),
    "Gaussian Mixture": gaussian_mixture,
}

cols = st.columns((70, 30))

with cols[0]:
    pdf_radio = st.radio(
        label="PDF $f_x$:",
        options=pdf_options,
        horizontal=True,
    )
    pdf = pdf_options[pdf_radio]

with cols[1]:
    L = st.slider(
        label="Número de níveis $L$:",
        min_value=2,
        max_value=16,
        value=10,
        step=1,
    )

def get_ts(vs):
    ii = np.arange(1, L)
    return (vs[ii - 1] + vs[ii]) / 2.0

def get_vs(Δ):
    ii = np.arange(L)
    return (ii - (L - 1) / 2.0) * Δ

def get_mse(vs, ts):
    ts = np.concatenate([[-10.0], get_ts(vs), [10.0]])
    mse = 0.0
    for i in range(L):
        xs = np.linspace(ts[i], ts[i + 1], num=10000)
        mse += np.trapezoid((vs[i] - xs) ** 2 * pdf(xs), xs)
    return mse

tabs = st.tabs(["Uniforme", "Não uniforme"])

def show_snr_and_pdf(vs, ts):
    xs = np.linspace(-10.0, 10.0, num=100000)
    Px = np.trapezoid(xs**2 * pdf(xs), xs)
    Pe = get_mse(vs, ts)
    snr_db = 10.0 * np.log10(Px / Pe)
    st.metric(label="$\\text{SNR}$ (dB)", value=f"{snr_db:.2f}")
    fig, ax = plt.subplots(figsize=(10, 5))
    ax.plot(xs, pdf(xs), linewidth=2)
    ax.plot(vs, pdf(vs), "C2o")
    ax.vlines(ts, ymin=-1.0, ymax=1.0, color="C1", linestyle="--")
    ax.set_xlabel("$x$")
    ax.set_ylabel("$f_x(x)$")
    ax.set_xlim(-6.0, 6.0)
    ax.set_ylim(-0.05, 0.75)
    ax.grid()
    st.pyplot(fig)

with tabs[0]:
    def fun(Δ):
        vs = get_vs(Δ)
        ts = get_ts(vs)
        return get_mse(vs, ts)
    res = optimize.minimize_scalar(fun=fun, bounds=(0.0, 5.0))
    Δ_opt = res.x  # type: ignore
    vs = get_vs(Δ_opt)
    ts = get_ts(vs)
    show_snr_and_pdf(vs, ts)

with tabs[1]:
    # Lloyd-Max algorithm
    vs = np.linspace(-1.0, 1.0, num=L)  # Initial guess
    for _ in range(200):
        ts = np.concatenate([[-10.0], get_ts(vs), [10.0]])
        vs = np.empty(L)
        for i in range(L):
            xs = np.linspace(ts[i], ts[i + 1], num=10000)
            vs[i] = np.trapezoid(xs * pdf(xs), xs) / np.trapezoid(pdf(xs), xs)
    show_snr_and_pdf(vs, ts)
