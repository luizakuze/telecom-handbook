# Arquiteturas de Sistemas Distribuídos 💻

## Estilos de arquitetura
Forma de projetar o SD

- `Baseada em camadas`
  - Ideia do TCP/IP
- `Baseada em objetos`
  - Objetos de poo, mas em máquinas diferentes
  - MQTT
- `Baseada em eventos`
  - Ideia do Whatsapp: Envia a mensagem pro middleware e depois o middleware entrega ao destino
  - Desacoplamento espacional
    - Publicado e assinador não conhecem os ips um dos outros
    - Parte precisam estar online
- `Baseada em espaço de dados compartilhados`
  - Partes não preci00sam estar online

## Arquiteturas de sistema
Organização do SD

- `Centralizada`
  - Cliente-servidor
  - Conjunto de clientes que 
  - Estratégias de clientes leves ou pesados.
    - Mais leve: Fácil de atualizar, porém desempenho ruim
    - Mais pesado: Difícil manter, melhor desempenho 
- `Descentralizada`
  - P2P
  - Estruturadas e não estruturadas
    - Estruturadas: Desempenho; Não tem nó central
    - Não estruturadas: Todos os nós na rede com mesma funcionalidade
  - Todos são servidores e clientes
  - Não há ponto único de falha
  - Escalabilidade
- `Híbrida`
  - Bittorrent
  - Ponto de falha é o tracker

---

# Materiais
- https://www.redhat.com/pt-br/topics/containers/whats-a-linux-container
- https://www.redhat.com/pt-br/topics/containers/what-is-docker
- https://www.redhat.com/pt-br/topics/microservices/what-are-microservices
- https://12factor.net/pt_br/


