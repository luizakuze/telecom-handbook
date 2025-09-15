# Ferramentas Básicas: WireShark, Encapsulamento e Tcpdump 🌷

## ☘️ Lista de comandos executados

| Comando                                                      | Descrição                                                                                 |
|--------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| `tcpdump`                                                    | Captura pacotes de rede que passam por uma interface.                                     |
| `man tcpdump`                                                | Abre o manual do comando `tcpdump`.                                                       |
| `sudo tcpdump`                                               | Executa o comando `tcpdump` com permissões administrativas para capturar pacotes de rede. |
| `man tcpdump \| grep "\-flag"`                               | Procura uma flag específica no manual do comando `tcpdump`.                               |
| `sudo tcpdump host xxx.xxx.x.x`                              | Captura pacotes oriundos e destinados à máquina xxx.xxx.x.x                               |
| `sudo tcpdump host xxx.xxx.x.x -vvv`                         | Captura de pacotes com maior verbosidade.                                                 |
| `sudo tcpdump host xxx.xxx.x.x -n`                           | Captura pacotes sem conversão de endereços (apresenta endereços numéricos).               |
| `sudo tcpdump host xxx.xxx.x.x -Q out`                       | Captura somente pacotes oriundos da máquina xxx.xxx.x.x                                   |
| `sudo tcpdump host xxx.xxx.x.x -Q in`                        | Captura somente pacotes destinados à máquina xxx.xxx.x.x                                  |
| `sudo tcpdump host xxx.xxx.x.x -w "pacotes_capturados.pcap"` | Salva no arquivo "pacotes_capturados.pcap".                                               |

## ☘️ Diferenças `tcpdump` x `ifconfig`
O tcpdump é uma ferramenta de captura de pacotes que permite monitorar e analisar o tráfego de rede em tempo real. Já o traceroute traça a rota aproximada entre dois hosts, mas não vê o tráfego da rede toda, apenas a rota.

--- 

## ☘️ Revisando roteiro da prática

###  🪻 Enviando pacotes para ifsc e verificando comunicação icmp:
```shell
ping4 ifsc.edu.br
sudo tcpdump -p icmp
```

### 🪻 Captura de pacotes oriundos e destinados à máquina xxx.xxx.x.x:
```shell
sudo tcpdump host xxx.xxx.x.x
```

### 🪻 Captura de pacotes oriundos e destinados à máquina xxx.xxx.x.x com detalhes adicionais (verbosidade):
```shell
sudo tcpdump host xxx.xxx.x.x -vvv
```
### 🪻 Captura de pacotes oriundos e destinados à máquina xxx.xxx.x.x sem resolução de nomes (endereços numéricos):
```shell
sudo tcpdump host xxx.xxx.x.x -n
```
### 🪻 Captura apenas de pacotes que saem da máquina xxx.xxx.x.x:
```shell
sudo tcpdump host xxx.xxx.x.x -Q out
```
### 🪻 Captura apenas de pacotes destinados à máquina xxx.xxx.x.x:
```shell
sudo tcpdump host xxx.xxx.x.x -Q in
```
### 🪻 Salva captura de pacotes oriundos e destinados à máquina:
```shell
sudo tcpdump host xxx.xxx.x.x -w "pacotes_capturados1.pcap"
```

## ☘️ Nota
Para conseguir o meu endereço ip no terminal, é preciso utilizar um dos comandos: `ifconfig` ou `ip a`