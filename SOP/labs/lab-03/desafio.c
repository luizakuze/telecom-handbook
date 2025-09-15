#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct {
    int idx, length, id;
} thread_arg, *ptr_thread_arg;

pthread_t threads[2];
int j = 0; // flag global controlando a vez

void *thread_func(void *arg) {
    ptr_thread_arg targ = (ptr_thread_arg) arg;

    for (int i = targ->idx; i < (targ->idx + targ->length); i++) {
        // espera ocupada enquanto não for sua vez
        while (j != targ->id);

        printf("Thread %lx – value %d\n", pthread_self(), i);

        // alterna a vez
        j = 1 - targ->id;
    }

    return NULL;
}

int main(int argc, char **argv) {
    thread_arg arguments[2];

    for (int i = 0; i < 2; i++) {
        arguments[i].idx = i * 10;
        arguments[i].length = 10;
        arguments[i].id = i;
        pthread_create(&threads[i], NULL, thread_func, &arguments[i]);
    }

    for (int i = 0; i < 2; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}
