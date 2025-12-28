# O que é a arquitetura da aplicação? 

> https://www.redhat.com/pt-br/topics/application-development-and-delivery/o-que-e-arquitetura-da-aplicacao

- Padrões utilizados para desenvolver uma aplicação. 

## Tipos

### Em camadas ou N camadas
- Aplicações legadas
- Cada camada tem suas próprias tarefas
- Cada camada só pode chamar as que estiverem abaixo dela

### Arquitetura monolítica
- Sistemas legados
- Único stack com todas as funcionalidades
- Uma alteração no código significa relançar a aplicação inteira


### Microsserviços
- Componentes pequenos (processos)
- Tolerância a falhas
- Escalabilidade dinâmica
- Fracamente acoplados
- Desenvolvedores podem trabalhar separados
- APIS e containers

### Arquitetura orientada por eventos
- Evento: Qualquer mudança de estado no software ou hardware, seja interna ou externa
- Pouco acoplamento
- Produtores e consumidores de eventos. 
- Produtor: detecta evento e representa como uma mensagem. Ele não sabe quem vai usar
- Consumidor: quem reage ao evento, executando alguma ação

### Arquitetura orientada por serviços (SOA)
- Similar aos microsserviços, mas com uma coordenação central (para microsserviço é descentralizada)
- Integração entre sistemas corporativos