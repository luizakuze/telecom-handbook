#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define N_READ 5
#define N_WRITE 2

int dados = 0;
int lendo = 0;
pthread_mutex_t mutex;
pthread_mutex_t acesso;

void pausa(int n) {
    sleep(rand() % n);
    usleep(rand() % 500000);
}

void *leitor(void *arg) {
    long id = (long)arg;

    while (1) {
        // entra como leitor
        pthread_mutex_lock(&mutex);
        lendo++;
        if (lendo == 1)
            pthread_mutex_lock(&acesso); // primeiro leitor bloqueia escrita
        pthread_mutex_unlock(&mutex);

        // leitura
        printf("L%ld leu valor: %d\n", id, dados);
        pausa(2);

        // sai como leitor
        pthread_mutex_lock(&mutex);
        lendo--;
        if (lendo == 0)
            pthread_mutex_unlock(&acesso); // último libera escrita
        pthread_mutex_unlock(&mutex);

        pausa(2);
    }

    return NULL;
}

void *escritor(void *arg) {
    long id = (long)arg;

    while (1) {
        // tenta escrever
        pthread_mutex_lock(&acesso);
        dados = rand() % 1000;
        printf("\t\tE%ld escreveu valor: %d\n", id, dados);
        pthread_mutex_unlock(&acesso);

        pausa(3);
    }

    return NULL;
}

int main() {
    srand(time(NULL));

    pthread_t r[N_READ], w[N_WRITE];

    // inicializa mutexes
    pthread_mutex_init(&mutex, NULL);
    pthread_mutex_init(&acesso, NULL);

    // cria leitores
    for (long i = 0; i < N_READ; i++)
        pthread_create(&r[i], NULL, leitor, (void *)i);

    // cria escritores
    for (long i = 0; i < N_WRITE; i++)
        pthread_create(&w[i], NULL, escritor, (void *)i);

    // espera as threads
    pthread_exit(NULL);
}
