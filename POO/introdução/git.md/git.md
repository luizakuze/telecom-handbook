# Introdução 1 - Terminal e Git

## Convenções da programação
- `CamelCase`
- `pascalCase`
- `snake_case` - em C
- `Kebab-case` - criar repositorio

##  Usuário associado a commits
```
git config --global user.name "Luiza Kuze" 
git config --global user.email "luizakuze08@gmail.com"
git config --global alias.tree "log --oneline --graph --decorate --all"
```

## Parte Inicial 

### Atalhos 

| Atalhos | Ação |
----|----
| ctrl + alt + T | Abre o terminal |
| ctrl + j | Abre terminal no vscode |

### Simbologias 

|Símbolo|Significado|
----|----
| ~ | Diretório "home" |
| $ | Usuário regular |
| # | Superusuário |
| . | Diretório atual |
| .. | Diretório pai |
| / ou c:\ | raíz |
| /home/usuarios/luiza | Caminho absoluto para 'luiza' |
| usuarios/luiza/| Caminho relativo para 'luiza' |

### Comandos pwd-cd-cat...

| Comando | Função |
----|----
| pwd | Listar o diretório que está |
| cd | Sem parâmetros, volta pro home |
| cat | Exibir o conteúdo de arquivos de texto |
| echo | Exibir mensagem de texto e variáveis |
| tree | Visualizar todos os diretórios a partir de um diretório específico |
| ps aux | Lista os processos em execução no sistema |
| kill -9 (processo) | Encerra um processo |


_Durante as aulas, ocorreu um erro ao inicializar o Intellij (IDE utilizada), pois foi instalado utilizando o "snap" que pode ocasionar alguns erros para alguns programas instalados. Então, solucionamos o problema com o comando "kill" para encerrar o processo e abrir novamente a IDE._

### Comandos ls-cd-mkdir

| Comando | Função |
----|----
| printenv | Mostra todas as varívaeis |
| mkdir | Criar um arquivo |
| gedit | Abre arquivo para edição |
| ls -la | Mostra conteúdo do arquivo |

_Caso o gedit não encontre um arquivo existente com aquele nome, ele cria um_

## Arquivo .gitignore
Esse é um arquivo para escrever tudo o que deve ser ignorado no programa. <br> Uma boa prática é criar um arquivo ".gitignore" em todo novo repositório. 

`*.class` - Aqui, vai ignorar todos os arquivos com extensão class.
Isso deve estar em um gitignore de um projeto java, já que um arquivo.java já gera um arquivo.class.

`!aula/*.log` - Se for dessa forma a escrita, fala para NÃO ignorar todos os arquios presentes com a extensão .log

Existem muitos arquivos que ficam "sobrando" em um projeto, então para auxiliar existe a ferramenta. <br>
Um site que gera automaticamente um gitignore dependendo da necessidade do projeto. `gitgnore.io`

Nosso .gitignore

```
# Created by https://www.toptal.com/developers/gitignore/api/java,visualstudiocode,intellij,windows,linux
# Edit at https://www.toptal.com/developers/gitignore?templates=java,visualstudiocode,intellij,windows,linux

### Intellij ###
# Covers JetBrains IDEs: IntelliJ, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio, WebStorm and Rider
# Reference: https://intellij-support.jetbrains.com/hc/en-us/articles/206544839

# User-specific stuff
.idea/**/workspace.xml
.idea/**/tasks.xml
.idea/**/usage.statistics.xml
.idea/**/dictionaries
.idea/**/shelf

# AWS User-specific
.idea/**/aws.xml

# Generated files
.idea/**/contentModel.xml

# Sensitive or high-churn files
.idea/**/dataSources/
.idea/**/dataSources.ids
.idea/**/dataSources.local.xml
.idea/**/sqlDataSources.xml
.idea/**/dynamic.xml
.idea/**/uiDesigner.xml
.idea/**/dbnavigator.xml

# Gradle
.idea/**/gradle.xml
.idea/**/libraries

# Gradle and Maven with auto-import
# When using Gradle or Maven with auto-import, you should exclude module files,
# since they will be recreated, and may cause churn.  Uncomment if using
# auto-import.
# .idea/artifacts
# .idea/compiler.xml
# .idea/jarRepositories.xml
# .idea/modules.xml
# .idea/*.iml
# .idea/modules
# *.iml
# *.ipr

# CMake
cmake-build-*/

# Mongo Explorer plugin
.idea/**/mongoSettings.xml

# File-based project format
*.iws

# IntelliJ
out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Cursive Clojure plugin
.idea/replstate.xml

# SonarLint plugin
.idea/sonarlint/

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

# Editor-based Rest Client
.idea/httpRequests

# Android studio 3.1+ serialized cache file
.idea/caches/build_file_checksums.ser

### Intellij Patch ###
# Comment Reason: https://github.com/joeblau/gitignore.io/issues/186#issuecomment-215987721

# *.iml
# modules.xml
# .idea/misc.xml
# *.ipr

# Sonarlint plugin
# https://plugins.jetbrains.com/plugin/7973-sonarlint
.idea/**/sonarlint/

# SonarQube Plugin
# https://plugins.jetbrains.com/plugin/7238-sonarqube-community-plugin
.idea/**/sonarIssues.xml

# Markdown Navigator plugin
# https://plugins.jetbrains.com/plugin/7896-markdown-navigator-enhanced
.idea/**/markdown-navigator.xml
.idea/**/markdown-navigator-enh.xml
.idea/**/markdown-navigator/

# Cache file creation bug
# See https://youtrack.jetbrains.com/issue/JBR-2257
.idea/$CACHE_FILE$

# CodeStream plugin
# https://plugins.jetbrains.com/plugin/12206-codestream
.idea/codestream.xml

# Azure Toolkit for IntelliJ plugin
# https://plugins.jetbrains.com/plugin/8053-azure-toolkit-for-intellij
.idea/**/azureSettings.xml

### Java ###
# Compiled class file
*.class

# Log file
*.log

# BlueJ files
*.ctxt

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files #
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
hs_err_pid*
replay_pid*

### Linux ###
*~

# temporary files which can be created if a process still has a handle open of a deleted file
.fuse_hidden*

# KDE directory preferences
.directory

# Linux trash folder which might appear on any partition or disk
.Trash-*

# .nfs files are created when an open file is removed but is still being accessed
.nfs*

### VisualStudioCode ###
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/*.code-snippets

# Local History for Visual Studio Code
.history/

# Built Visual Studio Code Extensions
*.vsix

### VisualStudioCode Patch ###
# Ignore all local history of files
.history
.ionide

### Windows ###
# Windows thumbnail cache files
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db

# Dump file
*.stackdump

# Folder config file
[Dd]esktop.ini

# Recycle Bin used on file shares
$RECYCLE.BIN/

# Windows Installer files
*.cab
*.msi
*.msix
*.msm
*.msp

# Windows shortcuts
*.lnk

# End of https://www.toptal.com/developers/gitignore/api/java,visualstudiocode,intellij,windows,linux
```

## Como criar mais de um diretório ao mesmo tempo
- Utilizar o **-p**
```
mkdir -p poo/aula-01 poo/aula-02 poo/aula-03
```

## Explicação de avançar nos diretórios 

Ao utilizar o ``cd ..`` volta para o diretório pai.

Diretório atual: /home/aluno/ <br>
Ao usar ``cd ..`` será levado para /home/

## Maneiras de usar o comando "cat"
```
cat /home/aluno/.gitconfig 
cat ../../../home/aluno/.gitconfig^C
cat $HOME/.gitconfig
cat ~/.gitconfig
```

## Comando ECHO x CAT

### ECHO
Visualiza o conteúdo texto diretamente e variáveis. Mensagens curtas.

#### Exemplo 1:
```
echo $HOME
echo $SHELL 
echo Olá, mundo!
```
#### Exemplo 2 - Variável de ambiente:
```
export POO="Aula"
echo $POO 
```
(nesse caso, aparece "Aula" no terminal)
#### Exemplo 3 - Redimensionando a saída da mensagem:
```
echo "Olá mundo" > ola.txt
```
(nesse caso, a mensagem sai no arquivo "ola.txt")

### **CAT** 
Conteúdo texto de um arquivo.

#### Exemplo 1:

```
cat arquivo.txt
```
#### Exemplo 2 - Chamando variável de ambiente:
```
cat $HOME/.gitconfig
```

## Comandos GIT

| Comando | Função |
----|----
| code .  | Abre vscode no diretório atual |
| cat ~/.gitconfig | Mostra o arquivo de configuração global do Git | 

| Comando | Função |
----|----
| git init | Inicializar o git |
| git branch -m main | Renomear a branch |
| git status | Mostra o estado atual do repositório |
| git add (arquivo) | Adiciona o arquivo ao ambiente git |
| git commit (arquivo) | Faz um commit |
| git commit -m "uma mensagem" | Faz um commit com mensagem |
| git log | Mostra o histórico de commits |
| git tree | Mostra o histórico de commits (- detalhado) |
| git checkout (branch) | Altera a branch do HEAD |
| git checkout main | Altera para branch principal ||
| git diff (arquivo) | Mostra alterações no arquivo não comitadas |
| git branch | Mostra a branch atual |
| git branch (branch) | Criando uma nova branch |
| git checkout (branch) | Troca a branch atual |
| git checkout -b (branch) | Cria e troca para branch atual |
| git merge (branch) | Mesclar duas branchs |
| git branch -d (branch) | Deleta a branch |
| git restore --staged (arquivo) | Retira um arquivo do git |
| git rm (arquivo) | Remove um arquivo do ambiente git |
| git branch -m (novaBranch) | Renomeia o nome da branch atual |

| Comando | Função |
----|----
| git clone (urlRepositorio) | Abrir repositório no computador |
| git push | Leva o repositório local para remoto |
| git pull | Leva o repositório remoto para local |

### Computador -> Github
O caminho que deve ser feito para passar um projeto que está inicialmente somente na própria máquina para passar para o github em um novo repositório.

1. Passo: Criar um novo repositório no github.

2. Passo: Ter certeza que o ramo principal se chama "main" e NÃO "master. Caso esteja MASTER: `git branch -M main`

3. Passo: Associar o repositório remoto com o novo do github: `git remote add origin (https://github.com/luizakuze/POO)`

4. Passo: Empurrar os arquivos do computador para o github: `git push -u origin main`

### Github -> Computador
O caminho que deve ser feito para abrir na própria máquina (repositório local) o repositório remoto do Github.

1. Passo: Clonar o projeto do Github `git clone (urlProjeto)`

2. Passo: Acessar o diretório do projeto: `cd (nomeDiretorio)`

3. Passo: Atualizar o repositório, para ter certeza que está na versão mais nova: `git pull`

### Problema de Sincronização do projeto
Quando duas pessoas trabalham no mesmo projeto simultaneamente sem sincronizar (pull) e ambas fazem commits com a versão desatualizada, pode ocorrer um conflito. <br> Esse confluto pode ser resolvido da seguinte forma:

1. Passo: Estar na branch main: `git checkout main`
2. Passo: Sincronizar: `git pull origin main`
3. Passo: Localizar o erro: `git status`
4. Passo: Abrir o arquivo no editor e resolver o conflito manualmente. Aparece de uma maneira similar:
```
<<<<<<< HEAD
Código da versão atual
====== 
Código da versão conflitante
>>>>>>> branch-conflitante
```
5. Passo: Com o problema resolvido, adicionar os arquivos para commit: `git add .` `git commit -m "Resolvendo onflitos entre as versões`
6. Passo: Enviar as alterações: `git push origin main`

### Comando cat ~/.gitconfig 
```
[user]
	name = Luiza Kuze
	email = luizakuze08@gmail.com
[alias]
	tree = log --oneline --graph --decorate --all
```
### Fazendo um commit simples

```
git pull
git add primeiro.md
git commit -m "Adicionando primeiro"
git push
```
### Dois comandos ao mesmo tempo
- Se conseguir realizar o primeiro comando, o seguindo acontece em sequência.
```
git add arquivo.txt && git commit -m "Adicionando arquivo"
```

### Ao realizar algumas alterações e não dar git add
```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   primeiro.md

no changes added to commit (use "git add" and/or "git commit -a")
```
#### O que fazer:
- `git add arquivo.txt`: Vai adicionar no git o arquivo com a última modificação.
- `git restore arquivo.txt`: vai restaurar o arquivo para versão anterior sem modificações.
#### Após isso, o ambiente deve estar da seguinte maneira:
```
On branch main
nothing to commit, working tree clean
```

### Commits, HEAD e branchs
- Cada commit tem uma identificação.
- `HEAD`: É a branch atual. Ao usar o comando 'ls', o que vai aparecer são os arquivos do head.
```
git tree
* 817ed09 (HEAD -> main) Adicionando terceiro
* c278ee7 Adicionando segundo
* 9b38b62 Adicionando primeiro
```

- Para mudar de branch:
```
git checkout 9b38b62
```

- O que mudou:
```
git tree
* 817ed09 (main) Adicionando terceiro
* c278ee7 Adicionando segundo
* 9b38b62 (HEAD) Adicionando primeiro
```

### Comando git status
#### Sem modificações 
```
git status       

On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```
#### Novo arquivo não rastreado 
```
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        script.js

nothing added to commit but untracked files present (use "git add" to track)
```

## Vscode

### Extensões
- Extension Pack for Java
- Gradle Extension Pack
- Extensao GitLens — Git supercharg
- Markdown github
