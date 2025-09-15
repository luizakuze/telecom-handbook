// Escrever um programa C que cria uma árvore de 3 processos,
// onde o processo A faz um fork() criando um processo B,
// o processo B, por sua vez, faz um fork() criando um processo C.
// Cada processo deve exibir uma mensagem "Eu sou o processo XXX, filho de YYY",
// onde XXX e YYY são os PIDs dos processos.
// Utilizar wait() para garantir que o processo C imprima sua resposta antes do B,
// e que o processo B imprima sua resposta antes do A.
// Utilizar sleep() para haver um intervalo de 1 segundo entre cada mensagem impressa.

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int pid, pid2, status;

    pid = fork();  // Processo A cria o processo B

    if (pid == -1) {
        perror("fork falhou!");
        exit(-1);
    } else if (pid == 0) {
        // Estamos no processo B

        pid2 = fork();  // Processo B cria o processo C

        if (pid2 == -1) {
            perror("fork falhou!");
            exit(-1);
        } else if (pid2 == 0) {
            // Estamos no processo C
            printf("Eu sou o processo C\tPID: %d\tFilho de: %d\n", getpid(), getppid());
        } else {
            // Processo B espera o C terminar
            wait(&status);
            sleep(1);
            printf("Eu sou o processo B\tPID: %d\tFilho de: %d\n", getpid(), getppid());
            exit(0);
        }

    } else {
        // Estamos no processo A (pai de B)
        wait(&status);
        sleep(1);
        printf("Eu sou o processo A\tPID: %d\tFilho de: %d\n", getpid(), getppid());
        exit(0);
    }
}
