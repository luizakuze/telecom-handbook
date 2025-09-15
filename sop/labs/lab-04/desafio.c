#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>


/* VARIÁVEIS GLOBAIS */
int flag = 0;
pthread_t threads[2];

// Atributos da thread
typedef struct {
    int idx, length;
} thread_arg, *ptr_thread_arg;


// Função para a thread
void *thread_func(void *arg) {
    // "Adiciona" parâmetro join para threads
    ptr_thread_arg targ = (ptr_thread_arg) arg;
    int i;

    for(i = targ->idx; i < (targ->idx + targ->length); i++)
        // Imprime o ID da thread e seu valor
        printf("Thread %lu – value %d\n", pthread_self(), i);
    return 0;
}

int main(int argc, char **argv) {
    thread_arg arguments[2];
    int i;
    for(i = 0; i < 2; i++) {
        arguments[i].idx = i * 10; 
        arguments[i].length = 10;

        // Cria uma thread no vetor de threads indicando a função thread_func
        // e passando como argumento o arguments[i]
        pthread_create(&(threads[i]), NULL, thread_func, &(arguments[i]));
    }
    // A main aguarda as threads serem finalizadas
    for(i = 0; i < 2; i++) {
        // Aguarda finalização da thread na posição i do vetor de threads 
        pthread_join(threads[i], NULL);
    } 

    return 0;
}
