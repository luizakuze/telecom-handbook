// O status passado como parâmetro à função wait(&status) é, 
// na verdade, o mecanismo de retorno de resultado do wait/waitpid.
// Ao retornar, esta variável contém informações sobre o resultado da execução
// do processo filho. Por exemplo, se um processo terminou normalmente (i.e.,
// chamou exit), o comando WIFEXITED(status) retorna true. Este comando retorna 
// false se o processo foi abortado (e.g., segmentation fault) ou morto (e.g., kill).
// Investigue no manual do wait no Linux (man wait) o funcionamento do comando 
// WEXITSTATUS(status), e use-o para modificar o exercício anterior para calcular 
// o 5!, sendo que cada processo pode executar apenas uma multiplicação.


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int status;
    int fatorial = 1; // 5! = 5 * 4 * 3 * 2 * 1
    int indice; 

    for (indice = 5; indice > 1; indice--) {
        pid_t pid = fork();

        if (pid < 0) {
            perror("fork falhou");
            exit(1);
        }

        if (pid > 0) {
            // Processo pai: espera o filho terminar
            wait(&status);

            // Verifica se o filho terminou normalmente com exit()
            if (WIFEXITED(status)) {
                // Recupera o valor retornado pelo filho (valor do exit(fatorial) anterior)
                int resultado_filho = WEXITSTATUS(status);

                // Multiplica o índice atual pelo resultado retornado pelo filho
                fatorial = indice * resultado_filho;
                printf("Processo %d multiplicou %d * %d = %d\n", getpid(), indice, resultado_filho, fatorial);

                // Termina o processo retornando o novo valor parcial do fatorial
                exit(fatorial);
            }  
        }
        // Se pid == 0, estamos no processo filho, ele continua o loop
        // e será o responsável por criar o próximo filho.
    }


    exit(1);
}
