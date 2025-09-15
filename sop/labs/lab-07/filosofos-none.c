#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define N 5

pthread_t filosofos[N];
pthread_mutex_t hashis[N];

char *espacos[] = { "", "\t", "\t\t", "\t\t\t", "\t\t\t\t" };

void pausa(int max) {
    sleep(rand() % max);
    usleep(rand() % 500000);
}

void *rotina_filosofo(void *arg) {
    long id = (long)arg;

    while (1) {
        // filosofo pensa
        printf("%smeditando\n", espacos[id]);
        pausa(2);

        int esq = id;
        int dir = (id + 1) % N;

        // tenta pegar os hashis (ordem muda dependendo do id)
        if (id % 2 == 0) {
            pthread_mutex_lock(&hashis[dir]);
            printf("%spega h%d\n", espacos[id], dir);
            pthread_mutex_lock(&hashis[esq]);
            printf("%spega h%d\n", espacos[id], esq);
        } else {
            pthread_mutex_lock(&hashis[esq]);
            printf("%spega h%d\n", espacos[id], esq);
            pthread_mutex_lock(&hashis[dir]);
            printf("%spega h%d\n", espacos[id], dir);
        }

        // come
        printf("%sCOMENDO\n", espacos[id]);
        pausa(2);

        // solta os hashis
        pthread_mutex_unlock(&hashis[esq]);
        printf("%slarga h%d\n", espacos[id], esq);
        pthread_mutex_unlock(&hashis[dir]);
        printf("%slarga h%d\n", espacos[id], dir);
    }

    return NULL;
}

int main() {
    srand(time(NULL));

    // inicializa mutex dos hashis
    for (int i = 0; i < N; i++)
        pthread_mutex_init(&hashis[i], NULL);

    // cria as threads dos filosofos
    for (long i = 0; i < N; i++)
        pthread_create(&filosofos[i], NULL, rotina_filosofo, (void *)i);

    // espera todas as threads (na prática, nunca termina)
    pthread_exit(NULL);
}
