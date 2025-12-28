# Comunicação 

## Processos
- Um processo nâo interfere no outro
- Áreas de memórias isoladas
- Comunicação (IPC):
    - Arquivos
    - Signals
        - Direto
    - Pipe
    - Sockets
        - Exige que estejam na mesma máquinas (ss -lx)
        - Melhor que arquivos
        - Em STD: SOckets tcp/ip
        - WebSockets é em htt

## Threads
- SERVIDOR EM std VAIA TER QUE SER MULTITHREAD P ATENDER CADA CLIENTE
_ nAVEGADOR WEB  VARIOS GETS NAVEGADOR BAIXA EM PARALELO

## Cliente e Servidor
-  ip:porta - tcp/udp
- linux:
   _ porta < 1024: Somente o root executa
   _ 65535 è a ùltima PORTA
   _ nâo usar uma porta que ja tem padronizado< oitenta oitenta ja vai ter algo vinte  um ftp
   _ ss traco tln
   - cat /etc/services

## FTP
- Modo ativo e passivo
- servidor conecta no clinente (omdo ativo), cliente abre uma porta. cliente nao mada mais nada enquanto o servidor mandar, cliente nao interrompe. problema:
- modo passivo: servidor fica esperando conexoes, enquanto ativo ele inicia coenxaco. 

sempre deixar cliente conectar no servidor

## Máquinas de estado pelo servidor
- Stateless: é como se o servdor nao vesse estados e o cliente falasse sempre em qualestado esta. nao fica viavel osevidor manetr 1 maquina de estados p cliente. Troca mais informacoes> ESSE é oproblema
- stateful: 

## Middleware
- fica na aplicação
- tipos decomunicacao persistencia de dados e transitoria
- sincornism
- fluxo

cliente servidor
- sincrono
- persistencia transitoria


## sockets
- fica entre aplicacao e trasnporte

- faze,os iente e servidor, socket peg bilioteca pronta


serializacao -/> pega info memoria e transformar me bytes p encaminhar pela rede. 


---

## Transmissão pela rede

- cliente pode ser em C e servidor pode ser em Java

- risc cisc

- pj eng concurso sef 

- 