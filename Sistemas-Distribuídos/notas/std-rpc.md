# RPC

## Dificuldades via sockets
- Arquiteturas diferentes 
- Java C, ... não tem cmo enviar classe pessoa do java, precisa SERIALIZAR. (serializar em bytes para poder transportar pela rede)
- Não tem transparência de acesso. ^^^

### RPC
- Chamada de funções
- stub -> middleware
- Marshalling: "Equivalente a serialização"
    - Representação implícito: Transmite valores
    - Representação explícito: Transmite valores e tipo do valor

## IDL
- Linguagem de Descrição de Interfaces
- Descreve uma "interface do java" para o servidor
- XDR para escrever como se fosse o ".h" de funções do C
- Dev do servidor faz o IDL, cliente deve ter acesso de alguma forma a estrutura da IDL que o servidor criou para poder desenvolver seu cliente.

## Port Mapper
- Serviço de descoberta para clientes descobrirem porta do servidor.

## RPC e RMI
- RPC e RMI já não são mais muito utiizados
- Para integração de aplicações não tem uso do RMI, somente uso local.