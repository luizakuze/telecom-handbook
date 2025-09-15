#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#define NUM_CARROS 20
#define NUM_CANCELAS 7
#define NUM_VAGAS 10

int vagas_ocupadas = 0;
int ordem_global = 0;
int ordem_atual = 0;

pthread_mutex_t mutex_vagas;
pthread_mutex_t mutex_cancelas[NUM_CANCELAS];
pthread_mutex_t mutex_ordem;
pthread_mutex_t mutex_filas_cancelas;

int fila_chegada[NUM_CARROS]; // ordem global de chegada
int fila_por_cancela[NUM_CANCELAS][NUM_CARROS]; // filas específicas por cancela
int tam_fila[NUM_CANCELAS] = {0}; // tamanho atual da fila de cada cancela

void imprimir_fila(int cancela) {
    printf("[");
    for (int i = 0; i < tam_fila[cancela]; i++) {
        printf("%d", fila_por_cancela[cancela][i]);
        if (i < tam_fila[cancela] - 1) printf(", ");
    }
    printf("] ");
}

void *carro(void *arg) {
    int id = (long) arg;
    int cancela = rand() % NUM_CANCELAS;

    // Adiciona carro à fila global
    pthread_mutex_lock(&mutex_ordem);
    fila_chegada[ordem_global] = id;
    int minha_ordem = ordem_global;
    ordem_global++;
    pthread_mutex_unlock(&mutex_ordem);

    // Adiciona carro à fila da cancela
    pthread_mutex_lock(&mutex_filas_cancelas);
    fila_por_cancela[cancela][tam_fila[cancela]] = id;
    tam_fila[cancela]++;
    printf("");
    imprimir_fila(cancela);
    printf("Carro %d chegou na cancela %d\n", id, cancela);
    pthread_mutex_unlock(&mutex_filas_cancelas);

    // Espera sua vez na fila global
    while (1) {
        pthread_mutex_lock(&mutex_ordem);
        if (fila_chegada[ordem_atual] == id) {
            pthread_mutex_unlock(&mutex_ordem);
            break;
        }
        pthread_mutex_unlock(&mutex_ordem);
        sleep(1);
    }

    // Espera vaga
    while (1) {
        pthread_mutex_lock(&mutex_vagas);
        if (vagas_ocupadas < NUM_VAGAS) {
            vagas_ocupadas++;
            pthread_mutex_unlock(&mutex_vagas);
            break;
        }
        pthread_mutex_unlock(&mutex_vagas);
        sleep(1);
    }

    // Passa pela cancela
    pthread_mutex_lock(&mutex_cancelas[cancela]);
    printf("Carro %d está passando pela cancela %d\n", id, cancela);
    sleep(5);
    pthread_mutex_unlock(&mutex_cancelas[cancela]);

    // Remove carro da fila da cancela
    pthread_mutex_lock(&mutex_filas_cancelas);
    int i;
    for (i = 0; i < tam_fila[cancela]; i++) {
        if (fila_por_cancela[cancela][i] == id) break;
    }
    for (; i < tam_fila[cancela] - 1; i++) {
        fila_por_cancela[cancela][i] = fila_por_cancela[cancela][i + 1];
    }
    tam_fila[cancela]--;
    pthread_mutex_unlock(&mutex_filas_cancelas);

    // Avança na ordem global
    pthread_mutex_lock(&mutex_ordem);
    ordem_atual++;
    pthread_mutex_unlock(&mutex_ordem);

    // Estacionado
    printf("Carro %d estacionado por 10 segundos\n", id);
    sleep(10);

    // Sai do estacionamento
    pthread_mutex_lock(&mutex_vagas);
    vagas_ocupadas--;
    pthread_mutex_unlock(&mutex_vagas);

    printf("Carro %d saiu do estacionamento\n", id);
    pthread_exit(NULL);
}

int main() {
    srand(time(NULL));
    pthread_t threads[NUM_CARROS];

    pthread_mutex_init(&mutex_vagas, NULL);
    pthread_mutex_init(&mutex_ordem, NULL);
    pthread_mutex_init(&mutex_filas_cancelas, NULL);
    for (int i = 0; i < NUM_CANCELAS; i++) {
        pthread_mutex_init(&mutex_cancelas[i], NULL);
    }

    for (long i = 0; i < NUM_CARROS; i++) {
        pthread_create(&threads[i], NULL, carro, (void *) i);
    }

    for (int i = 0; i < NUM_CARROS; i++) {
        pthread_join(threads[i], NULL);
    }

    // Limpeza
    pthread_mutex_destroy(&mutex_vagas);
    pthread_mutex_destroy(&mutex_ordem);
    pthread_mutex_destroy(&mutex_filas_cancelas);
    for (int i = 0; i < NUM_CANCELAS; i++) {
        pthread_mutex_destroy(&mutex_cancelas[i]);
    }

    printf("Todos os carros já passaram pelo estacionamento.\n");
    return 0;
}
