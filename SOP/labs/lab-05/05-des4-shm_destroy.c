#include <stdio.h>      
#include <stdlib.h>     
#include <sys/ipc.h>     
#include <sys/shm.h>     

#define SHM_SIZE 1024   

int main() {
    key_t key;       
    int shmid;       

    // Gera uma chave única com base no caminho "/tmp" e no caractere 'X'
    // Essa chave será usada para identificar o segmento de memória
    if ((key = ftok("/tmp", 'X')) == -1) {
        perror("ftok error"); 
        exit(1);        
    }

    // Obtém o ID do segmento de memória compartilhada correspondente à chave
    // Deve ser o mesmo segmento criado anteriormente com shmget e IPC_CREAT
    if ((shmid = shmget(key, SHM_SIZE, 0644)) == -1) {
        perror("shmget error"); 
        exit(1);          
    }

    // Remove o segmento de memória compartilhada identificado por shmid
    // IPC_RMID indica que queremos destruir/remover o segmento
    if (shmctl(shmid, IPC_RMID, NULL) == -1) {
        perror("shmctl error");  
        exit(1);
    }

    // Confirmação para o usuário de que o segmento foi removido com sucesso
    printf("shm_destroy executado\n");

    return 0;
}
