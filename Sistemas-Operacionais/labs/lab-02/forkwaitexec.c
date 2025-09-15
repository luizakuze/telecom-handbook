
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#define MAX_INPUT 1024

// (ex.: /usr/bin/ls, /usr/bin/gedit, /usr/bin/firefox)

int main() {
    char input[MAX_INPUT];

    while (1) {
        printf("embrionico> ");
        fflush(stdout);

        if (!fgets(input, MAX_INPUT, stdin)) {
            break;
        }

        // Remover o '\n' do final
        input[strcspn(input, "\n")] = '\0';
 
        if (strcmp(input, "sair") == 0) {
            break;
        }

        // Verifica se o comando é em background (termina com '&')
        int background = 0;
        int len = strlen(input);
        if (len > 0 && input[len - 1] == '&') {
            background = 1;
            input[len - 1] = '\0'; // remove o '&'
        }

        // Divide o input em programa e argumentos
        char *args[100];
        int i = 0;
        char *token = strtok(input, " ");
        while (token != NULL && i < 99) {
            args[i++] = token;
            token = strtok(NULL, " ");
        }
        args[i] = NULL;

        if (args[0] == NULL) {
            continue; // se o comando estiver vazio
        }

        pid_t pid = fork();

        if (pid < 0) {
            perror("fork falhou");
        } else if (pid == 0) {
            // Processo filho
            if (execve(args[0], args, NULL) == -1) {
                perror("execve falhou");
                exit(EXIT_FAILURE);
            }
        } else {
            // Processo pai
            if (!background) {
                waitpid(pid, NULL, 0);
            } else {
                printf("[rodando em background] PID: %d\n", pid);
            }
        }
    }

    return 0;
}
