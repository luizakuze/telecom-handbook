# Comunicação confiável

- TCP garante confiança, mas em caso de uso do UDP pode trazer a confiabilidade p outra camada
- Requisição idempotente: Estado do servidor não muda independente do número de requisições
- Na camada de aplicação lidar com falhas por queda de processos.

---

# Comunicação orientada a mensagens

- Comunicação transitória: 2 partes precisam estar ativas e disponíveis.
- Modelo pull Vs modelo push
- Ver no wireshark o spotify
    - Antigamente RTP/UDP
    - Hoje HTTP2/TCP
- google fcm, apple apn, ...

# Fila de mensagens

- Fila de mensagens: put, get, poll, notify
- AMQP: 
    - Implementações RabbitMQ, Apache Qpid e Apache ActiveMQ
- MQTT:
    - pub/sub
    - iot
    - Implementação: mosquitto
