#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>

char *message = "This is a message!!!";

int main()
{
    char buf[1024];
    int fd[3][2];

    for (int i = 0; i < 4; i++)
    {
        pipe(fd[i]);
    }

    // PROCESSO 0
    if (fork() != 0)
    {
        write(fd[0][1], message, strlen(message) + 1);
        printf("Process 0: Writing\n");

    }
    else
    { 
        read(fd[0][0], buf, 1024);
        printf("Process 0: Got this from MaMa!!: %s\n", buf);

        // PROCESSO 1
        if (fork() != 0)
        {  
            write(fd[1][1], message, strlen(message) + 1);
            printf("Process 1: Writing\n");
        }
        else
        { 
            read(fd[1][0], buf, 1024);
            printf("Process 1: Got this from MaMa!!: %s\n", buf);

            // PROCESSO 2
            if (fork() != 0)
            { 
                write(fd[2][1], message, strlen(message) + 1);
                printf("Process 2: Writing\n");
            }
            else
            {  
                read(fd[2][0], buf, 1024);
                printf("Process 2: Got this from MaMa!!: %s\n", buf);
            }
        }
    }

    return 0;
}