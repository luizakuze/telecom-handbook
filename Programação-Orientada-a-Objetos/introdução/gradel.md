# Anotações - Gradel e pacotes
O gradle permite abrir um projeto java fora da idea. 

Precisa da JRE (ambiente de execução java).<br>
Não precisa necessariamente do JDK (kit dev java).

## Retirar excesso de informações do gradle
Caso o gradle mostre muitas mensagens na saída, <br>
proceder da seguinte forma:

1 - Criar um arquivo chamado `gradel.properties`; <br>
2 - Escrever nesse arquivo: 
```
org.gradle.console=plain
org.gradle.logging.level=quiet
```

Onde criar o arquivo: `$HOME/.gradle/gradel.properties`


## Organização Gradle
- resources: Arquivos de imagem.
- gradle - wrapper - properties: Versão gradle.
- gradle - wrapper - ...jar: Torna possível compilar e executar um .java sem q a máquina tenha jvm.
`.jar`: Empacotar uma aplicação em java, um "zip".
-gradelw: 


## Comandos

| Comando | Função |
----|----
| gradle init | Iniciar um projeto com gradle |
| ./gradlew.bat build | Compilar em windowns |
| gradlew.bat | Executar em windowns |
| ./gradlew clean | Deletar arquivos temporários/script | 
|./gradlew run | Executar a aplicação|
| ./gradlew tasks | Listar tarefas possíveis | 
| cat gradle/wrapper/gradle-wapper.properties | Ver a versão atual do gradle |

## Arquivo build.gradle

### Dependências / dependencies
Especifica as bibliotecas e dependências que o projeto requer para compilação e execução.

### Plugins
Adiciona plugins do Gradle para estender as capacidades do sistema de construção. Por exemplo, plugins para aplicativos Java, Android, Spring Boot, etc.

O código abaixo "explica" para o gradle qual a classe principal que deve ser executada.

```gradle
plugins {
    id 'application'
}

application {
    mainClass= 'engtelecom.poo.App'
}
```

### Repositório / repositories
Indica de onde da internet pode baixar biliotecas de terceiros, caso elas não estejam ainda no projeto.

## Diferença Repositório x Dependência
### Repositórios
Repositórios são como lojas onde você encontra peças para construir seu projeto. Existem, por exemplo, lojas locais (onde você guarda suas coisas) e lojas online/remoto (onde todos compartilham).

No build.gradle, você diz ao projeto onde procurar por essas lojas!

### Dependências:

São as peças que você precisa para construir seu projeto. Relacionando com um quebra-cabeças: cada peça é uma dependência. 

No build.gradle, você lista as peças que precisa. Um exemplo são as peças do quebra-cabeças (bibliotecas) para o projeto.

Quando você constrói seu projeto, o sistema de construção pega essas peças das lojas (repositórios) e as encaixa para fazer tudo funcionar.

>_"Repositórios são onde você busca as peças (dependências) para construir seu projeto, e dependências são as peças individuais que seu projeto precisa. O build.gradle ajuda a montar tudo corretamente."_

## Projeto Gradel - Linha de Comando

```gradle
gradle init

Select type of project to generate:
Enter selection (default: basic) [1..4] 2

Select implementation language:
Enter selection (default: Java) [1..6] 3

Generate multiple subprojects for application? (default: no) [yes, no] no

Select build script DSL:
Enter selection (default: Groovy) [1..2] 1

Select test framework:
Enter selection (default: JUnit Jupiter) [1..4] 4

Project name (default: primeiro): primeiro

Source package (default: primeiro): engtelecom.poo

Enter target version of Java (min. 7) (default: 17): 17

Generate build using new APIs and behavior (some features may change in the next minor
release)? (default: no) [yes, no] no
```
## Projeto Gradel - VScode

_LEMBRETE: Criar o projeto com gradle via terminal durante as aulas!_

1) Criar um diretório vazio e abrir com o VSCode:
```cmd
mkdir projeto
cd projeto
code .
```
2) Abrir o prompt de comando do VSCode _(Ctrl + Shift ⇑ + P)_:
3) Digitar `create a gradle java project (advanced)`
4) Escolher: `application`
5) Escolher: `groovy`
6) Escolher: `JUnit Jupiter`
7) Informar o nome do projeto.
8) Informar o nome do pacote Java para o projeto _(`engtelecom.poo`)_.


## Empacotar aplicação Java

- É entregue em um pacote com exntensão `.jar`

O plugin 'application' provê 2 tarefas:

1) **distZip** - Cria `app.zip` no subdiretório `build/distributions` que contém a JRE.
2) **installDist** - Gera scripts em app/build/install/app que permite executar a aplicação.

> _Usar o **distZip** para distribuir o código para outras pessoas e usar o **installDist** para realizar meus próprios testes em meu computador_


### Uso distZip
1) No diretório do do projeto: `./gradlew distZip`

- _Um zip da aplicação foi criado!_

2) Descompactar zio: `unzip build/distributions/app.zip`
3) Executar o script: `./bin/app`


### Uso InstallDist
1) No diretório do do projeto: `./gradlew distInstall`

- _Estrutura de diretórios da aplicação foi criada!_

2) `cd build/install`
3) `cd app`
4) Executar o script: `./bin/app`

#### Revisão copiar/Descompactar via terminal
- Copiar arquivo para o main (~): `cp app.zip ~`
- Descompactar arquivo pelo terminal: `unzip app.zip`


/////////

Sempre usar gradle init p criar, n pela idea
