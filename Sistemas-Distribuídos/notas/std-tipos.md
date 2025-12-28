# Tipos de Sistemas Distribuídos 💻

## Sistemas de informação distribuídos

- Transações devem garantir integridade dos recursos
- "Ou todas as operações na transação são executadas ou nenhuma delas será executada"
- `ACID`
  - Atômica
  - Consistente
  - Isolada
  - Duráveis
  
- Exemplo: Sistemas distribuídos ubíquos
  - “Estar em toda parte, de forma invisível e integrada ao ambiente”
  - Dispositivos móveis pequenos, alimentados por abteria e conexão sem fio
  - Exemplo: IoT

## Tipos

### Computação de Alto Desempenho (HPC)
- Uso de supercomputadores para resolver problemas que exigem alta capacidade de processamento de dados. 

### Grades computacionais (GRID)
- Conceta recursos heterogêneos de instituições diferente para resover problemas complexos de forma colaborativa.
 
### Computação em Nuvem (Cloud Computing)
- Oferecer como serviço aplicações e estrutura para hospedar elas. 
- `Nuvem`: Conjunto de hardware e software no datacenter.
- `Modelo de implantação`
  - `Nuvem privada`
    - A nuvem é construída e usada por uma única instituição.
    - Uso para, por exemplo, empresas que exigem maior controle do ambiente. Custo com equipamentos
    - Custo com equipamentos
  - `Nuvem pública`
    - Serviços oferecidos por provedores a qualquer cliente.
    - Uso para, por exemplo, projetos de curto prazo e startups. 
    - Custo da mensalidade pelo uso de recursos.

- `Modelos de serviço`
  - `SaaS`: Software as a Service
    - Voltado ao usuário final
    - Responsabilidade do cliente: Usar o software
    - O software já vem pronto para consumir
    - Exemplo: Gmail e Office 365
  - `PaaS`: Plataform as a Service
    - Voltado ao desenvolvedor de aplicações
    - Responsabilidade do cliente: Escrever o código
    - Retira do desenvolvedor a tarefa de criar e implantar a plataforma da aplicação.
    - Exemplo: Microsoft Azure
  - `IaaS`: Infrastructure as a Service
    - Voltado ao analista de redes
    - Responsabilidade do cliente: SO, middleware, máquinas virtuais e quaisquer aplicativos.
    - Retira do analista a tarefa de gerenciar a intraestrutura do datacenter.
    - Exemplo: Microsoft Azure e Amazon AWS

> CLOUD: "Clusters acessados por um middleware"
 
### Computação em Névoa (Fog Computing)
- Poder de processamento mais perto do limite da borda da rede
- Dados são distribupidos e colocados em local eficientes

> FOG: "Trazer a 'nuvem' para mais perto dos dispositivos"

