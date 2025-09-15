from numpy import array, cov, empty, eye, mean, random, set_printoptions

# Parâmetros
N = 1000000  # Número de realizações

# Experimento
B = random.binomial(n=1, p=1/2, size=(3, N))
X = empty((3, N))
X[0] = B[0]
X[1] = B[0]*B[1]
X[2] = B[0]*B[1]*B[2]

# Cálculos
ev_B_teo = array([1/2, 1/2, 1/2])
ev_B_sim = mean(B, axis=1)
cov_B_teo = array([[1/4, 0, 0], [0, 1/4, 0], [0, 0, 1/4]])
cov_B_sim = cov(B)
ev_X_teo = array([1/2, 1/4, 1/8])
ev_X_sim = mean(X, axis=1)
cov_X_teo = array([[1/4,  1/8, 1/16], [1/8, 3/16, 3/32], [1/16, 3/32, 7/64]])
cov_X_sim = cov(X)

# Saída
set_printoptions(precision=4, suppress=True, floatmode="fixed")
print(f"Teo: E[B] = {ev_B_teo}")
print(f"Sim: E[B] = {ev_B_sim}")
print(f"Teo: cov[B] =\n{cov_B_teo}")
print(f"Sim: cov[B] =\n{cov_B_sim}")
print()
print(f"Teo: E[X] = {ev_X_teo}")
print(f"Sim: E[X] = {ev_X_sim}")
print(f"Teo: cov[X] =\n{cov_X_teo}")
print(f"Sim: cov[X] =\n{cov_X_sim}")
