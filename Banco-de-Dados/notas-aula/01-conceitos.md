# Introdução a Bancos de Dados 

## 🎲 Conceitos sobre Banco de Dados

- **Banco de Dados (BD):** Coleção de dados inter-relacionados.
- **Sistema de Gerenciamento de Banco de Dados (SGDB):** Programas que permitem acessar e modificar dados.
- **Dicionário de Dados:** Metadados (exemplo: autorização dos dados, quem pode acessar eles).

O usuário faz uma ação na aplicação, o SGBD processa essa consulta e faz o acesso aos dados armazenados.

---

### Modelos de Banco de Dados

Tratam da descrição dos dados, relacionamentos e semântica.

- **Entidade-Relacionamento (ER):** Modelagem baseada em entidades (substantivos) e relacionamentos (verbos). Mais próximo do mundo real.
- **Modelo Relacional:** Impelmentação lógica que representa dados e relacionamentos em forma de tabelas.
- **Baseado em Objetos:** Extensão do ER com noção de encapsulamento e identidade do objeto Com JPA, esse modelo não é mais utilizado diretamente.
- **Modelo Semi-estruturado:** Permite registro de um tipo ter diferentes atributos. Exemplo: XML e JSON.

 
---

### Esquema (Schema)

- Implementação concreta dentro do modelo. Define o formato dos dados armazenados no banco. "Esquema" de tabelas e colunas no banco de dados

---


### Níveis de Abstração

- **Nível Físico:** Como os dados são armazenados (disco, memória). Não há uma ordenação. SGBD tem acesso
- **Nível Lógico:** Como os dados estão estruturados (tabelas, colunas, relacionamentos). Devs e DBAs tem acesso.
- **Nível de Visão:** Como os dados são apresentados aos usuários. Usuários finais tem acesso.


---

## 🎲 Formalização

### DDL - Linguagem de Definição de Dados

- Linguagem para edpecificação do schema.
- Compilador DDL gera um conjunto de tabelas em um conjunto de arquivos chamado `dicionário de dados`.


### DML - Linguagem de Manipulação de Dados
- Acesso e manipulação de dados. (Select)
- SQL é uma linguagem de consulta, enquanto MySQL é um SGDB.

### Normalização: 
- Criar um conjunto de tabelas que permite não haver redundância dos campos.

### Propriedades ACID

- **Atomicidade:** A transação ocorre por completo ou não ocorre.
- **Consistência:** O banco mantém um estado válido após cada transação.
- **Isolamento:** Transações simultâneas não se afetam mutuamente.
- **Durabilidade:** Dados confirmados permanecem armazenados após transação.
- `Como garantir ACID`
    - Para garantir atomicidade e durabilidade: Utilizar logs. 
    - Para isolamento: Controle de concorrência (timestamps e MVCC).
    - Para consistência: Regras de integridade e transações bem definidas.

---

## 🎲 Big Data & NoSQL
 

- **Big Data:** Refere-se a grandes volumes de dados, com grande variedade e velocidade de geração.
- **Hadoop e MapReduce:** Tecnologias populares para processamento de Big Data.

### NoSQL

- Para armazenar vasta quantidade de dados. 
- **Não utiliza o modelo relacional tradicional.**
- Principais estruturas:
    - Chave-valor
    - Colunas esparsas
    - Grafos
    - Orientado a documentos


### Modelo BASE  
 
Similar ao ACID, mas para NoSQL

- **Basic Availability:** : Garante que o sistema esteja sempre disponível para respostas, mesmo em situações de falha, mas sem garantir que os dados estejam imediatamente consistentes.
- **Soft-state:** O sistema pode estar em um estado intermediário por um tempo. Não há garantia de que os dados estejam completos ou consistentes a qualquer momento, mas eles se ajustam ao longo do tempo, permitindo maior flexibilidade.
- **Eventual Consistency:** Os dados serão consistentes eventualmente.

### Modelo ACID ou BASE
- **ACID:** Usado em bancos SQL (ex: transações bancárias) devido à necessidade de consistência e segurança nas transações críticas, onde falhas podem causar danos sérios. `Sistemas críticos`
- **BASE:** Usado em NoSQL (ex: redes sociais), onde a disponibilidade e escalabilidade são prioritárias, permitindo que os dados se tornem consistentes com o tempo, mesmo em ambientes de alta carga.

--- 

## Sistemas Distribuídos

### Escalabilidade

- **Escalonamento Vertical:** Adicionar recursos a um único nó. Pode exigir parada da máquina.
- **Escalonamento Horizontal:** Adicionar novos nós ao cluster. Sistemas distribuídos, mais flexível.

### Teorema CAP (Bancos distribuídos)

- **Consistência**: Todos os nós têm os mesmos dados ao mesmo tempo.
- **Disponibilidade**: O sistema responde a todas as solicitações.
- **Tolerância a Partições**: O sistema funciona mesmo com falhas de rede.

Sempre há necessidade de tolerância a partições, mas é necessário escolher entre consistência ou disponibilidade. Geralmente, prioriza-se a consistência.

---

## Anotações adicionais
- Em um banco relacional, uma **tupla** corresponde a uma linha de tabela.
- Chaves:
    - **Chave Primária:** Identificador único de um registro.
    - **Chave Estrangeira:** Referência de uma chave primária de outra tabela.
    - **Chave Primária Composta:** Formada por dois ou mais atributos, onde cada um pode ser uma chave estrangeira.
