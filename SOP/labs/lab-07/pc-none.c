#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#define N_PROD 3
#define N_CONS 5
#define TAM_BUFFER 6

int buffer = 0;
pthread_mutex_t lock;
sem_t vagas, itens;

void espera(int n) {
    sleep(rand() % n);
    usleep(rand() % 500000);
}

void *produtor(void *arg) {
    long id = (long)arg;
    printf("Produtor %ld ativo\n", id);

    while (1) {
        espera(2);

        // espera vaga no buffer
        sem_wait(&vagas);

        // entra na região crítica
        pthread_mutex_lock(&lock);
        buffer++;
        printf("P%02ld produziu (%d itens no buffer)\n", id, buffer);
        pthread_mutex_unlock(&lock);

        // sinaliza que tem item disponível
        sem_post(&itens);
    }

    return NULL;
}

void *consumidor(void *arg) {
    long id = (long)arg;
    printf("Consumidor %ld ativo\n", id);

    while (1) {
        espera(2);

        // espera item disponível
        sem_wait(&itens);

        // entra na região crítica
        pthread_mutex_lock(&lock);
        buffer--;
        printf("C%02ld consumiu (%d itens no buffer)\n", id, buffer);
        pthread_mutex_unlock(&lock);

        // sinaliza vaga no buffer
        sem_post(&vagas);
    }

    return NULL;
}

int main() {
    srand(time(NULL));

    pthread_t prod[N_PROD], cons[N_CONS];

    // inicializa sincronizadores
    pthread_mutex_init(&lock, NULL);
    sem_init(&vagas, 0, TAM_BUFFER);
    sem_init(&itens, 0, 0);

    // cria produtores
    for (long i = 0; i < N_PROD; i++)
        pthread_create(&prod[i], NULL, produtor, (void *)i);

    // cria consumidores
    for (long i = 0; i < N_CONS; i++)
        pthread_create(&cons[i], NULL, consumidor, (void *)i);

    // espera as threads
    pthread_exit(NULL);
}
