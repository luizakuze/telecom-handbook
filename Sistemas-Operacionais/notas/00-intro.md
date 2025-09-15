# Introdução

## Tópicos Gerais

- **Relação entre Hardware, SO e Software**  
  - O sistema operacional (SO) atua como intermediário entre o hardware e o software.  

- **Por que jogos pareciam melhores antigamente?**  
  - Questões de otimização, estilo artístico e limitações técnicas que favoreciam um design mais polido.  

- **Drives e Utilitários**  
  - **Drivers (baixo nível):** Responsáveis pela comunicação direta com o hardware, como a divisão de pacotes.  
  - **Utilitários (alto nível):** Programas que oferecem funcionalidades ao usuário, abstraindo detalhes técnicos.  

- **USB e Transmissão de Dados**  
  - Comunicação serial (bit a bit), ao contrário da transmissão paralela.  

- **Comando para verificar processadores:**  
  ```bash
  cat /proc/cpuinfo
  ```  

- **Processos daemon:**  
  - Processos que executam tarefas específicas no SO, como a fila de impressão.  

- **Interface gráfica (X) e o Kernel**  
  - O X Server é responsável apenas pela parte gráfica, enquanto o kernel gerencia os recursos do sistema.  
  - Ambientes gráficos como KDE e GNOME são camadas sobre o X Server.  

- **Listagem de arquivos detalhada:**  
    ```bash
    ls -la
    # drwxrwxr-x 8 lulu lulu 4096 Mar 17 10:38 .git
    # -rw-rw-r-- 1 lulu lulu 1067 Mar 17 10:38 LICENSE
    ```  

## Usos do Sistema Operacional

- **Abstração de Recursos**  
  - Permite a independência do hardware e acesso homogêneo a dispositivos.  
  - Processo ocorre de cima para baixo.

- **Gerenciamento de Recursos**  
  - Sequencia o acesso a recursos para evitar conflitos.  
  - Processo ocorre de baixo para cima.

## Gerenciamento no SO

- **Gerenciamento de Memória**  
  - Impede que um aplicativo acesse o espaço de outro.  

- **Gerenciamento de Arquivos**  
  - Centraliza os arquivos, utilizando ponteiros para diretórios diferentes.  

## Alguns Tipos de Sistemas Operacionais

- **SO Servidor**  
- **SO Distribuído**  
- **SO Móvel**  
  - Aplicativos podem ser ativados por notificações.  
- **SO de Tempo Real**  
  - Operações devem ocorrer em tempos previsíveis.
