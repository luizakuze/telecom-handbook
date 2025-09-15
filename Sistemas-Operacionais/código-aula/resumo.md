### 🧠 `fork()`
- **Cria um novo processo.**
- Quando você chama `fork()`, o processo atual é *duplicado*.
- O processo pai recebe o **PID do filho**, e o processo filho recebe **0**.
- A partir daí, os dois processos continuam rodando em paralelo, mas **a partir da linha onde o `fork()` foi chamado.**

---

### 🧠 `wait(&status)`
- **Faz o processo pai esperar o término de um filho.**
- Quando o processo filho termina, o pai continua.
- O valor de `status` guarda informações **sobre como o filho terminou** (se deu certo, se deu erro, etc).

---

### 🧠 `sleep(segundos)`
- **Pausa o processo por um tempo**, em segundos.
- É só um delay: o processo para por aquele tempo, depois continua normal.

---

### 🧠 `exit(código)`
- **Termina o processo com um valor de retorno.**
- Esse valor (ex: `exit(3)`) pode ser lido pelo pai usando `WEXITSTATUS(status)` depois de `wait()`.

---

### 🧠 `WIFEXITED(status)`
- Verifica **se o filho terminou normalmente**, com `exit()`.
- Retorna **true (1)** se sim, ou **false (0)** se o filho terminou com erro (ex: segfault, killed, etc).

---

### 🧠 `WEXITSTATUS(status)`
- Depois que `wait(&status)` rodou e `WIFEXITED(status)` deu true,
- Você pode usar `WEXITSTATUS(status)` para **pegar o valor que o filho retornou com `exit(valor)`**.

---

### 🧪 Exemplo rápido:
```c
if (fork() == 0) {
    // Processo filho
    exit(42); // termina com "código de saída" 42
} else {
    int status;
    wait(&status); // espera o filho terminar

    if (WIFEXITED(status)) {
        int resultado = WEXITSTATUS(status);
        printf("Filho retornou: %d\n", resultado); // Vai imprimir 42
    }
}
```
