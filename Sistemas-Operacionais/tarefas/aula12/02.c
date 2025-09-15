#define N 5 // Número de filósofos
sem_t garfo[N]; // Semáforos para os garfos
void filosofo(int i) {
    int primeiro = i;
    int segundo = (i + 1) % N;

    if (primeiro > segundo) {
        int tmp = primeiro;
        primeiro = segundo;
        segundo = tmp;
    }

    while (1) {
        medita();

        sem_down(&garfo[primeiro]);
        sem_down(&garfo[segundo]);

        come();

        sem_up(&garfo[segundo]);
        sem_up(&garfo[primeiro]);
    }
}




