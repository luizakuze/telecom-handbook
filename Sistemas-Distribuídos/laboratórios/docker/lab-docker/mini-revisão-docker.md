# Mini revisão Docker 🐋


## Diferenças entre VMs e Contêineres 

- **Máquinas Virtuais (VMs)**: Compartilham os recursos do sistema, mas cada VM precisa de um sistema operacional completo, o que pode causar problemas no gerenciamento de recursos e criar inconsistências entre diferentes sistemas operacionais.
  - Compartilhamento de recursos
  - Dá de exportar tbm coo docker, mas é muito grande e nem sempre dá de usar.
  
- **Contêineres (Docker)**: Um contêiner inclui apenas o aplicativo e as bibliotecas necessárias, sem precisar de um sistema operacional completo, o que resulta em maior eficiência e menor uso de recursos. 
  - Isolamento de aplicações
  - Ambiente repredutível
  - Podman
  - Kubernetes
  
## Microsserviços

- Um contêiner para cada aplicação (e.g., MySQL, Redis, Java), a ideia de microsserviços são vários containers separados que juntos formam o serviço completo.

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

### Dockerfile  
- `RUN apt update && apt -y install git nyancat figlet`: Instala vários pacotes. É necessário o update antes do install.
- `EXPOSE 8000`: Expõe a porta 8000. Por padrão é a 8000, mas é uma boa prática colocar.
- `RUN` é executado na construção da imagem, `CMD` é executado quando vira contêiner.
- Cada contêiner tem seu próprio IP, mas ao mapear porta, é acessível via `localhost:8000`.

# Revisão 

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

# Comandos do Dockerfile

```docker
#FROM ubuntu:latest

#RUN apt update && apt -y install git nyancat figlet

FROM eclipse-temurin:21-jdk

COPY www /www

WORKDIR /www

EXPOSE 8000

CMD [ "jwebserver", "-b", "0.0.0.0" ]
```

```docker
# 1. Escolhe a imagem base
FROM ubuntu:22.04

# 2. Metadados (informações sobre a imagem)
LABEL maintainer="luiza@exemplo.com"
LABEL version="1.0"
LABEL description="Exemplo de Dockerfile com comandos básicos"

# 3. Variáveis de build (ARG só existe no build)
ARG APP_VERSION=1.0

# 4. Definir variáveis de ambiente (ficam no container em runtime)
ENV APP_HOME=/app \
    PORT=8080

# 5. Define o diretório de trabalho
WORKDIR $APP_HOME

# 6. Copiar arquivos do host para o container
COPY requirements.txt .
COPY src/ ./src

# 7. ADD pode baixar arquivos externos ou descompactar .tar
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/local/bin/

# 8. Executar comandos no build (instalar pacotes, libs, etc.)
RUN apt-get update && apt-get install -y \
    python3 python3-pip curl \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /usr/local/bin/wait-for-it.sh \
    && pip3 install --no-cache-dir -r requirements.txt

# 9. Criar volume (para persistir dados)
VOLUME ["/data"]

# 10. Expõe a porta que o app vai usar
EXPOSE $PORT

# 11. ENTRYPOINT é o comando fixo
ENTRYPOINT ["python3", "src/app.py"]

# 12. CMD são argumentos default (podem ser sobrescritos)
CMD ["--version", "${APP_VERSION}"]

# docker build -t minha_imagem:1.0 .
# docker run --name meu_container -p 8080:8080 minha_imagem:1.0

```

# Comandos do Docker Compose

```docker
#version: '3.8'
services:
  servidorweb:
    build: servidorweb
    ports:
      - 8000:8000
  bancodedados:
    image: mysql
    ports:
      - 3306:3306
    #volumes:
    #  - servidorweb/www:/www
  redis:
    image: redis
    ports:
      - 6379:6379

# docker compose build
# docker compose up
```

---

Cliente é o docker e ele envia p servidor requisicoes o docker daemon

Podman



JDK e JRE
  - somente ambiente de desenvolvimento jre



  RUN gera smepre uma mnova camada, ideal agrpar docmando com &&

docker build -t minha-imagem .


boa pratica remover o apt update depois de buildar uma vez

por padrao caimos no /

]

Nao criar arquivo dieto no docker fi

volume mapeia container pra host

docker run -it --rm -v $(pwd):/app minha-imagem

diretorio pc atual : drietio do ocntianer

tentar reproduzir 



run -p 1234:8000

jwebserver -b 0.0.0.0

imagem webserver q suba o jwebserver e colocar o index html