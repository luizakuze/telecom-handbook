# Usando UML

```bash
aluno: ~$ ls
'Área de trabalho'   Downloads   Modelos   POO       snap    'VirtualBox VMs'
 Documentos          Imagens     Música    Público   Vídeos
aluno: ~$ cd Downloads/
aluno: Downloads$ ls
'poo-aula-08-modificadores-de-acesso (1).pdf'
 poo-aula-08-modificadores-de-acesso.pdf
 poo-aula-09-exercicio.pdf
 poo-aula-09-reservadas-colecoes.pdf
 poo-aula-associacao-entre-classes.pdf
 StarUML_6.0.1_amd64.deb
aluno: Downloads$ dpkg -x StarUML_6.0.1_amd64.deb staruml

 StarUML_6.0.1_amd64.deb
aluno: Downloads$ dpkg -x StarUML_6.0.1_amd64.deb staruml
aluno: Downloads$ ld
ld: nenhum arquivo de entrada
aluno: Downloads$ ls
'poo-aula-08-modificadores-de-acesso (1).pdf'
 poo-aula-08-modificadores-de-acesso.pdf
 poo-aula-09-exercicio.pdf
 poo-aula-09-reservadas-colecoes.pdf
 poo-aula-associacao-entre-classes.pdf
 staruml
 StarUML_6.0.1_amd64.deb
aluno: Downloads$ cd staruml/
aluno: staruml$ ls
opt  usr
aluno: staruml$ ./opt/StarUML/staruml --no-sandbox
libva error: /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so init failed
[20769:1005/090105.998589:ERROR:sandbox_linux.cc(374)] InitializeSandbox() called with multiple threads in process gpu-process.
APPIMAGE env is not defined, current application is not an AppImage
```

## Site prof
emersonmello.me

## Anotações do projeto 1

- relógio digital
- display
- 7 sgmentos
- tamanho p m g (nao é classe)