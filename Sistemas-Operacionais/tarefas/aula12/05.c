#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

#define TOTAL 5

sem_t controle;
sem_t sincronizador;
int atingiram_barreira = 0;

void espera_barreira() {
    sem_wait(&controle);
    atingiram_barreira++;

    if (atingiram_barreira == TOTAL) {
        sem_post(&sincronizador);
    }
    sem_post(&controle);

    sem_wait(&sincronizador);
    sem_post(&sincronizador);
}

void* rotina(void* arg) {
    int id = *(int*)arg;

    printf("Etapa 1 - Thread %d\n", id);
    espera_barreira();

    printf("Etapa 2 - Thread %d\n", id);
    espera_barreira();

    printf("Etapa 3 - Thread %d\n", id);
    return NULL;
}

int main() {
    pthread_t th[TOTAL];
    int ids[TOTAL];

    sem_init(&controle, 0, 1);
    sem_init(&sincronizador, 0, 0);

    for (int i = 0; i < TOTAL; i++) {
        ids[i] = i;
        pthread_create(&th[i], NULL, rotina, &ids[i]);
    }

    for (int i = 0; i < TOTAL; i++) {
        pthread_join(th[i], NULL);
    }

    return 0;
}