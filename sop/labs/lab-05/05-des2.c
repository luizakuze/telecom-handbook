#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("Erro nos parâmetros\n");
        return (-1);
    }

    int buf_size = 1024;
    char buf[buf_size];
    int fd[2];

    // Cria o pipe
    if (pipe(fd) == -1)
    {
        perror("Erro ao criar o pipe");
        return -1;
    }

    if (fork() != 0)
    {                                   // Processo pai (envia)
        FILE *fp = fopen(argv[1], "r"); // Abre o arquivo de entrada
        if (fp != NULL)
        {
            // Lê o conteúdo do arquivo para o buffer
            size_t newLen = fread(buf, sizeof(char), buf_size, fp);
            if (ferror(fp) != 0)
            {
                fputs("Erro de leitura", stderr);
                return (-1);
            }
            else
            {
                // Escreve no pipe
                write(fd[1], buf, newLen);
            }
            fclose(fp);
        }
        else
        {
            perror("Erro ao abrir o arquivo de entrada");
            return -1;
        }
    }
    else
    {                 // Processo filho (recebe)
        close(fd[1]); // Fecha a parte de escrita do pipe no processo filho
        ssize_t bytesRead = read(fd[0], buf, buf_size);
        if (bytesRead == -1)
        {
            perror("Erro ao ler do pipe");
            return -1;
        }

        FILE *fp = fopen(argv[2], "ab+");
        if (fp != NULL)
        {
            // Escreve no arquivo de saída
            fwrite(buf, sizeof(char), bytesRead, fp);
            fclose(fp);
        }
        else
        {
            perror("Erro ao abrir o arquivo de saída");
            fclose(fp);
            return -1;
        }
    }

    return 0;
}
