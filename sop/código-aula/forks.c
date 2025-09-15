#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int x = 1;
    char* label = "P1";  // Começa com o processo pai original

    printf("Início do processo %s: PID = %d, PPID = %d\n", label, getpid(), getppid());

    pid_t pid1 = fork();

    if (pid1 == 0) {
        label = "P2";  // Primeiro filho do pai original
        printf("[%s] PID = %d, PPID = %d (fork 1)\n", label, getpid(), getppid());
    } else {
        printf("[%s] criou %s: PID = %d\n", label, "P2", pid1);
    }

    sleep(1); // só pra organizar a saída

    if (pid1 > 0) {
        wait(0); // P1 espera P2
    }

    pid_t pid2 = fork();

    if (pid2 == 0) {
        if (pid1 == 0) {
            label = "P3"; // filho de P2
        } else {
            label = "P4"; // segundo filho de P1
        }
        printf("[%s] PID = %d, PPID = %d (fork 2)\n", label, getpid(), getppid());
    } else {
        printf("[%s] criou %s: PID = %d\n", label, (pid1 == 0) ? "P3" : "P4", pid2);
    }

    if (pid2 > 0) {
        wait(0); // P1 e P2 esperam seus respectivos filhos
    }

    x++;
    printf("[%s] PID = %d: Valor final de x = %d\n", label, getpid(), x);

    return 0;
}
