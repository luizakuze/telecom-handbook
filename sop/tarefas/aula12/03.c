#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

// Declaração dos semáforos
sem_t sem_bart;
sem_t sem_lisa;
sem_t sem_maggie;

// Flag de controle de fluxo
int controle = 0;

void* tarefa_bart(void* arg) {
    while (1) {
        sem_wait(&sem_bart);
        printf("Bart se move\n");
        sem_post(&sem_lisa);
    }
    return NULL;
}

void* tarefa_lisa(void* arg) {
    while (1) {
        sem_wait(&sem_lisa);
        printf("Lisa se move\n");
        if (controle == 0) {
            sem_post(&sem_maggie);
            controle = 1;
        } else {
            sem_post(&sem_bart);
            controle = 0;
        }
    }
    return NULL;
}

void* tarefa_maggie(void* arg) {
    while (1) {
        sem_wait(&sem_maggie);
        printf("Maggie se move\n");
        sem_post(&sem_lisa);
    }
    return NULL;
}

int main() {
    pthread_t t_bart, t_lisa, t_maggie;

    // Inicialização dos semáforos
    sem_init(&sem_bart, 0, 1);   // Bart inicia
    sem_init(&sem_lisa, 0, 0);
    sem_init(&sem_maggie, 0, 0);

    // Criação das threads
    pthread_create(&t_bart, NULL, tarefa_bart, NULL);
    pthread_create(&t_lisa, NULL, tarefa_lisa, NULL);
    pthread_create(&t_maggie, NULL, tarefa_maggie, NULL);

    // Espera pelas threads (loop infinito)
    pthread_join(t_bart, NULL);
    pthread_join(t_lisa, NULL);
    pthread_join(t_maggie, NULL);

    return 0;
}
