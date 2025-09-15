# Docker: Máquinas Virtuais x Contêineres 🍓

# 🍓 Aula 01 🍓
## Diferenças entre VMs e Contêineres 🌱 

- **Máquinas Virtuais (VMs)**: Compartilham os recursos do sistema, mas cada VM precisa de um sistema operacional completo, o que pode causar problemas no gerenciamento de recursos e criar inconsistências entre diferentes sistemas operacionais.
  
- **Contêineres (Docker)**: Um contêiner inclui apenas o aplicativo e as bibliotecas necessárias, sem precisar de um sistema operacional completo, o que resulta em maior eficiência e menor uso de recursos.

    >**Kubernetes**: Facilita o gerenciamento de múltiplos contêineres em ambientes mais complexos.

## Comandos Docker Básicos 🌱 

### Listar Imagens Locais
```bash
docker images
```

### Baixar uma Imagem do Docker Hub
```bash
docker pull ubuntu
```

### Executar um Contêiner no Modo Interativo
- Modo interativo signinfica que vai abrir a shell
    ```bash
    docker run -it --name primeiro ubuntu bash
    ```

    Comandos para executar dentro do modo interativo:
    ```bash
    apt update          # Atualizar a base de pacotes
    apt install nano    # Instalar o editor de texto nano
    apt install nyancat # Instalar o nyancat (exemplo divertido)
    exit                # Sair do shell (o contêiner para de rodar)
    ```

### Listar Todos os Contêineres (Incluindo os Parados)
```bash
docker ps -a
```




---

# Aula 02 🍓

### Construir imagem do diretório atual
```bash
docker build -t seg-ads .
```

### Subir contêiner e apagar logo após execução
```bash
docker run -it --rm seg-ads
```

### Mapeamento de Porta: Subir servidor web na porta 8000
- Cada container tem um IP próprio (não será o localhost local padrão), tem que mapear IP da porta de lá do container com a nossa localhost para conseguir acessar.
    ```bash
    docker run -p 8000:8000 servidorweb
    ```

### Volumes: Mapeando diretório local para dentro do contêiner
- `$(pwd)/www`: Diretório atual local.
- `/www`: Diretório dentro do container onde o diretório local especificado será montado.
    ```bash
    docker run -p 8000:8000 -v $(pwd)/www:/www servidorweb
    ```

### Docker Compose
- Gerenciar diversos containers, não é preciso mais construir individualmente cada uma das imagens e subir cada um dos containers.
    ```bash
    docker-compose up # subir serviços
    docker-compose up -d # subir serviços em segundo plano
    ```

---

### Dicas:
- `FROM ubuntu:latest`: Base da imagem.
- `RUN apt update && apt -y install git nyancat figlet`: Instala vários pacotes. É necessário o update antes do install.
- `EXPOSE 8000`: Expõe a porta 8000. Por padrão é a 8000, mas é uma boa prática.
- `RUN` é executado na construção da imagem, `CMD` é executado quando vira contêiner.
- Cada contêiner tem seu próprio IP, mas ao mapear porta, é acessível via `localhost:8000`.
- Microsserviços: Um contêiner para cada aplicação (e.g., MySQL, Redis, Java), a ideia de microsserviços são vários containers separados que juntos formam o serviço completo.
- Para abrir um shell no contêiner de forma interativa no próprio VSCode: Acessar a extensão do Docker e clicar com o botão direito no respectivo container, após isso acessar a opção `docker attach`.


#### Executar Contêiner com Java  
- Este comando executa um contêiner com Java pronto para uso, ideal para quando você precisa rodar programas Java em uma máquina que não tem o Java instalado.
    ```bash
    docker pull eclipse-temurin:21-jdk-alpine
    ```

    ```bash
    docker run -it --name terceiro eclipse-temurin:21-jdk-alpine ash
    ```

#### Habilitando Docker na máquina 
- Esse comando é usado para configurar e instalar o Docker em modo "rootless" no sistema. 
    ```bash
    dockerd-rootless-setuptool.sh install
    ```

#### Instalar pacotes sem perguntar
- Sempre vai selecionar "Y" entre "(Y/n)" automaticamente, sem perguntar ao usuário.
    ```bash
    apt -y install
    ```
---

# Revisão 🍓

```bash
docker images # listar imagens locais
docker ps -a # listar todos os containers (incluindo os parados)
docker pull <imagem> # baixar imagem do Docker Hub
docker run -it <imagem> bash # executar em modo interativo
docker run --name primeiro <imagem>  # executa e dá nome ao container
docker build -t <imagem> . # construir imagem do diretório atual
docker run -it --rm <imagem> # subir container e remover após execução
docker run -p 8000:8000 <imagem> # mapeando portas
docker run -p 8000:8000 -v $(pwd)/www:/www servidorweb # mapear volume local para dentro do container
docker-compose up # subir serviços com Docker Compose
``` 