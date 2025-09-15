#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>

// Estrutura do Rendez-Vous
typedef struct rvt {
    sem_t espera1;
    sem_t espera2;
    int contador;
    pthread_mutex_t mutex;
} rvt;

// Inicializacao do Rendez-Vous
void rviniciar(rvt* rv) {
    sem_init(&rv->espera1, 0, 0);
    sem_init(&rv->espera2, 0, 0);
    rv->contador = 0;
    pthread_mutex_init(&rv->mutex, NULL);
}

// Função de espera no Rendez-Vous
void rvaguardar(rvt* rv) {
    pthread_mutex_lock(&rv->mutex);

    rv->contador++;
    if (rv->contador == 1) {
        pthread_mutex_unlock(&rv->mutex);
        sem_wait(&rv->espera1);
        sem_post(&rv->espera2);
    } else {
        sem_post(&rv->espera1);
        sem_wait(&rv->espera2);
        rv->contador = 0;
        pthread_mutex_unlock(&rv->mutex);
    }
}  

// Exemplo de uso com dois processos
void* processo_A(void* arg) {
    rvt* rv = (rvt*) arg;
    printf("A1\n");
    rvaguardar(rv);
    printf("A2\n");
    rvaguardar(rv);
    printf("A3\n");
    return NULL;
}

void* processo_B(void* arg) {
    rvt* rv = (rvt*) arg;
    printf("B1\n");
    rvaguardar(rv);
    printf("B2\n");
    rvaguardar(rv);
    printf("B3\n");
    return NULL;
}

int main() {
    pthread_t tA, tB;
    rvt ponto_encontro;

    rviniciar(&ponto_encontro);

    pthread_create(&tA, NULL, processo_A, &ponto_encontro);
    pthread_create(&tB, NULL, processo_B, &ponto_encontro);

    pthread_join(tA, NULL);
    pthread_join(tB, NULL);

    return 0;
}
