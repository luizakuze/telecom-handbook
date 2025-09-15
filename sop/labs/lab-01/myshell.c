#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include <linux/limits.h>
#include <dirent.h>
#include <time.h>

// Equivalente ao pwd
int mycwd() {
    char cwd[PATH_MAX];
    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        printf("%s\n", cwd);
        return 0;
    } else {
        perror("getcwd() error");
        return 1;
    }
}

// Cria diretório
int mymkdir(const char *pathname) {
    if (mkdir(pathname, 0755) == 0) {
        printf("Diretório criado\n");
        return 0;
    } else {
        perror("mkdir() error");
        return 1;
    }
}

// Remove diretório
int myrmdir(const char *pathname) {
    if (rmdir(pathname) == 0) {
        printf("Diretório removido\n");
        return 0;
    } else {
        perror("rmdir() error");
        return 1;
    }
}

// Muda de diretório
int mycd(const char *pathname) {
    if (chdir(pathname) == 0) {
        return mycwd(); // mostra onde está após mudar
    } else {
        perror("chdir() error");
        return 1;
    }
}

// Exibe informações do arquivo
int mystat(const char *filepath) {
  struct stat info;

  if (stat(filepath, &info) == 0) {
      printf("File: %s\n", filepath);
      printf("Permissions: %o\n", info.st_mode & 0777);

      char atime_str[64], mtime_str[64];
      strftime(atime_str, sizeof(atime_str), "%Y-%m-%d %H:%M:%S", localtime(&info.st_atime));
      strftime(mtime_str, sizeof(mtime_str), "%Y-%m-%d %H:%M:%S", localtime(&info.st_mtime));

      printf("Last access:       %s\n", atime_str);
      printf("Last modification: %s\n", mtime_str);
      return 0;
  } else {
      perror("stat() error");
      return 1;
  }
}

// Lista conteúdo de diretório
int myls() {
    char dirpath[PATH_MAX];

    printf(">>> Path to directory (default '.'): ");
    scanf("%s", dirpath);

    DIR *directory = opendir(dirpath);
    if (directory == NULL) {
        perror("myls() error");
        return 1;
    }

    printf("Contents of directory '%s': ", dirpath);

    struct dirent *entry;
    while ((entry = readdir(directory)) != NULL) {
        printf("%s\n", entry->d_name);
    }

    closedir(directory);
    return 0;
  }


// Interpretador simples de comandos
int main(int argc, char** argv) {
    int running = 1;

    while (running) {
        char command[60], argument[PATH_MAX] = ".";

        printf("myshell> ");
        int args_read = scanf("%s", command);

        // Verifica se o comando precisa de argumento
        if (strcmp(command, "exit") == 0) {
            running = 0;

        } else if (strcmp(command, "cwd") == 0) {
            mycwd();

        } else if (strcmp(command, "mkdir") == 0) {
            scanf("%s", argument);
            mymkdir(argument);

        } else if (strcmp(command, "rmdir") == 0) {
            scanf("%s", argument);
            myrmdir(argument);

        } else if (strcmp(command, "cd") == 0) {
            scanf("%s", argument);
            mycd(argument);

        } else if (strcmp(command, "stat") == 0) {
            scanf("%s", argument);
            mystat(argument);
        } else if (strcmp(command, "ls") == 0) {
            myls();  
        } else {
            printf("Comando não encontrado\n");
        }
    }

    return 0;
}
