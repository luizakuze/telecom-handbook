// Definição de semáforos
semaphore vagas_B1 = N1;     // Vagas disponíveis em B1
semaphore itens_B1 = 0;      // Itens disponíveis em B1
semaphore mutex_B1 = 1;      // Exclusão mútua para B1

semaphore vagas_B2 = N2;     // Vagas disponíveis em B2
semaphore itens_B2 = 0;      // Itens disponíveis em B2
semaphore mutex_B2 = 1;      // Exclusão mútua para B2

// Função do produtor X
void* produtor_X(void* arg) {
    while (true) {
        item dado_X = produzir_X();

        wait(&vagas_B1);
        wait(&mutex_B1);
        inserir(B1, dado_X);
        signal(&mutex_B1);
        signal(&itens_B1);
    }
}

// Função do intermediário Y
void* intermediario_Y(void* arg) {
    while (true) {
        wait(&itens_B1);
        wait(&mutex_B1);
        item dado_Y = retirar(B1);
        signal(&mutex_B1);
        signal(&vagas_B1);

        item dado_processado = processa_Y(dado_Y);

        wait(&vagas_B2);
        wait(&mutex_B2);
        inserir(B2, dado_processado);
        signal(&mutex_B2);
        signal(&itens_B2);
    }
}

// Função do consumidor Z
void* consumidor_Z(void* arg) {
    while (true) {
        wait(&itens_B2);
        wait(&mutex_B2);
        item dado_Z = retirar(B2);
        signal(&mutex_B2);
        signal(&vagas_B2);

        consumir(dado_Z);
    }
}
