# Desvendando o HTTP com Wireshark - Básico 🌷

## ☘️  A Interação Básica GET/Resposta do HTTP

1. Acessei a URL: [http://redes.sj.ifsc.edu.br](http://redes.sj.ifsc.edu.br) pelo navegador.
2. Iniciei a captura de pacotes no Wireshark.
3. Parei a captura após carregar a página.
4. Adicionei o filtro no Wireshark: `ip.addr == 191.36.8.36 and http`.

Vi que a diferença entre os endereços IP e portas de origem e destino nas mensagens HTTP GET e de resposta está no fato de que um endereço atua como o cliente (seu navegador) e o outro como servidor (ifsc).

## ☘️ Interação Básica GET/Resposta do HTTP usando TELNET e Requisição Manual

### Parte 1: Utilizando HTTP 1.0 com Telnet
Executei os comandos abaixo em um terminal para simular uma requisição HTTP 1.0:
```bash
telnet -4 redes.sj.ifsc.edu.br 80
GET / HTTP/1.0
<Enter> <Enter>
``` 

### Parte 2: Utilizando HTTP 1.1 com Telnet
Executei os comandos abaixo em um terminal para simular uma requisição HTTP 1.1:
```bash
telnet -4 redes.sj.ifsc.edu.br 80
GET / HTTP/1.1
HOST: redes.sj.ifsc.edu.br
<Enter> <Enter>
```

### Parte 3: Conexão HTTP Persistente
O protocolo HTTP/1.1 oferece suporte para conexões persistentes, o que significa que você pode fazer várias requisições na mesma conexão TCP, sem ter que reabri-la a cada requisição. Para testar isso, segui os passos abaixo:
```bash
telnet -4 redes.sj.ifsc.edu.br 80
GET / HTTP/1.1
HOST: redes.sj.ifsc.edu.br
<Enter> <Enter>
GET /Redes_arq1.html HTTP/1.1
HOST: redes.sj.ifsc.edu.br
<Enter> <Enter>
```
Você verá que a conexão permanece aberta entre as requisições, permitindo que você faça várias requisições sucessivas sem ter que abrir uma nova conexão TCP.

## ☘️ Diferenças entre HTTP 1.0 e HTTP 1.1

- **Conexão Persistente:** ⚠️
  - **HTTP 1.0:** Fecha a conexão após cada requisição, a menos que seja explicitamente indicado o uso de "keep-alive".
  - **HTTP 1.1:** As conexões são mantidas abertas por padrão, suportando múltiplas requisições e respostas na mesma conexão TCP, o que melhora a eficiência.

- **Cabeçalho "Host":**
  - **HTTP 1.0:** O cabeçalho "Host" é opcional.
  - **HTTP 1.1:** O cabeçalho "Host" é obrigatório, pois permite a hospedagem de múltiplos domínios em um único endereço IP.
 
## ☘️ O Comando `telnet`

O comando `telnet` é uma ferramenta de linha de comando usada para conectar-se a servidores por meio do protocolo Telnet, permitindo a comunicação bidirecional baseada em texto com servidores remotos. No contexto de redes e do protocolo HTTP, ele pode ser utilizado para enviar requisições manuais e visualizar as respostas do servidor sem o uso de um navegador.

### Exemplo de uso:
```bash
telnet <host> <porta>
```
Onde `<host>` é o endereço do servidor e `<porta>` é o número da porta (ex: 80 para HTTP).

