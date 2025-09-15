#include <stdio.h>
#include <stdlib.h>
#include <ucontext.h>

#define STACKSIZE 32768 /* tamanho de pilha das threads */

/* VARIÁVEIS GLOBAIS */
ucontext_t cPing, cPong, cMain;

/* Funções-comportamento das Tarefas */
// Comportamento de ping
void f_ping(void * arg) {
   int i;

   printf("%s iniciada\n", (char *) arg); 

   for (i=0; i<4; i++) {
      printf("%s %d\n", (char *) arg, i);
      // Salva o contexto atual na variável cPing e 
      // restaura o contexto salvo anteriormente na variável cPong
      swapcontext(&cPing, &cPong);
   }
   printf("%s FIM\n", (char *) arg);

   swapcontext(&cPing, &cMain);
}

// Comportamento de pong
void f_pong(void * arg) {
   int i;

   printf("%s iniciada\n", (char *) arg);

   for (i=0; i<4; i++) {
      printf("%s %d\n", (char *) arg, i);
      // Salva o contexto atual na variável cPong e 
      // restaura o contexto salvo anteriormente na variável cPing
      swapcontext(&cPong, &cPing);
   }
   printf("%s FIM\n", (char *) arg);

   swapcontext(&cPong, &cMain);
}

/* MAIN */
int main(int argc, char *argv[]) {
   char *stack;

   printf ("Main INICIO\n");

   // Salva o contexto em cPing
   getcontext(&cPing); 

   // Cria a pilha para cPing
   stack = malloc(STACKSIZE);
   if(stack) { 
      cPing.uc_stack.ss_sp = stack ;
      cPing.uc_stack.ss_size = STACKSIZE;
      cPing.uc_stack.ss_flags = 0;
      cPing.uc_link = 0;
   }
   else {
      perror("Erro na criação da pilha: ");
      exit(1);
   }

   // Ajusta os parâmetros internos do contexto salvo em cPing
   makecontext(&cPing, (void*)(*f_ping), 1, "\tPing");

   // Salva o contexto em cPong
   getcontext(&cPong);


   // Cria a pilha para cPong
   stack = malloc(STACKSIZE);
   if(stack) {
      cPong.uc_stack.ss_sp = stack ;
      cPong.uc_stack.ss_size = STACKSIZE;
      cPong.uc_stack.ss_flags = 0;
      cPong.uc_link = 0;
   }
   else {
      perror("Erro na criação da pilha: ");
      exit(1);
   }

   // Ajusta os parâmetros internos do contexto salvo em cPong
   makecontext (&cPong, (void*)(*f_pong), 1, "\tPong");

   //Salva o contexto atual na variável cMain e 
   // restaura o contexto salvo anteriormente na variável cPing
   swapcontext(&cMain, &cPing);
   //Salva o contexto atual na variável cMain e 
   // restaura o contexto salvo anteriormente na variável cPong
   swapcontext(&cMain, &cPong);

   printf("Main FIM\n");

   exit(0);
}
