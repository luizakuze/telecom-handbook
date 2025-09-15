# Modelagem Relacional
## Esquema
```sql
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);
```

## Instância
```sql
id | nome         | email
---|--------------|---------------------
 1 | Maria Silva  | maria@email.com
 2 | João Pereira | joao@email.com
```

## Chaves
- Primary Key PK: Coluna(s) que valores disitnguem uma linha das demais
- Foreign Key FK: Coluna(s) que valores aparecem na chave primária de outra tabela.

- Relação referenciadora: A tabela que possui a chave estrangeira (foreign key).
- Relação referenciada:	A tabela que é apontada pela chave estrangeira.

## Princípios

### 1. Inclusão de linha na tabela com chave estrangeira

```sql
-- Primeiro, insere um cliente (referenciado)
INSERT INTO clientes (id_cliente, nome) VALUES (1, 'Maria');
```

✅ Funciona, pois o cliente 1 existe na tabela clientes.
```sql 
-- Agora pode inserir um pedido (referenciador), usando o ID do cliente
INSERT INTO pedidos (id_pedido, id_cliente, produto)
VALUES (100, 1, 'Notebook');
``` 

❌ Vai dar erro: violação de integridade referencial.
```sql 
INSERT INTO pedidos (id_pedido, id_cliente, produto)
VALUES (101, 999, 'Celular');  -- cliente 999 não existe
```

### 2. Alteração do valor da chave estrangeira
✅ Vai funcionar se o novo id_cliente (1) existir em clientes.
```sql 
-- Suponha que você quer mudar o cliente do pedido 100
UPDATE pedidos
SET id_cliente = 1
WHERE id_pedido = 100;
```

❌ Erro, pois cliente 999 não existe. 
```sql 
UPDATE pedidos
SET id_cliente = 999
WHERE id_pedido = 100;
```

### 3. Exclusão de linha na tabela referenciada
```sql 
DELETE FROM clientes WHERE id_cliente = 1;
```

❌ Vai dar erro se existirem pedidos com id_cliente = 1.

Soluções possíveis:

Usar ON DELETE CASCADE → deleta os pedidos junto

Usar ON DELETE SET NULL → deixa o campo id_cliente nulo

Exemplo com CASCADE:

```sql 
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    produto VARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

```
Agora, se você deletar um cliente, os pedidos dele também somem.

### 4. Alteração do valor da chave primária referenciada
```sql 
UPDATE clientes SET id_cliente = 2 WHERE id_cliente = 1;

```
❌ Isso não é permitido por padrão, porque existem pedidos com id_cliente = 1.

Só funciona se:

Atualizar também a chave estrangeira (id_cliente) na tabela pedidos

Ou usar ON UPDATE CASCADE na definição da foreign key

Exemplo com CASCADE:
```sql 
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON UPDATE CASCADE

```
Aí, se mudar o id_cliente em clientes, o valor muda também em pedidos.

## Linguagem SQL e notação resumida
- Linguagem SQL é a linguagem padrão
```
CREATE TABLE Aluno (idAluno INT NOT NULL, Nome VARCHAR(45) NULL,
Curso_idCurso INT NOT NULL,
PRIMARY KEY (idAluno),
CONSTRAINT fk_Aluno_Curso
FOREIGN KEY (Curso_idCurso)
REFERENCES Curso (idCurso));
```

- Representação resumida
```
Aluno (idAluno, Nome, idCurso)
idCurso referencia Curso

Curso (idCurso, Nome)
```
## Boas Práticas
- Evitar JOIN
- Minimizar número de chaves e índices
- Evitar campos opcionais

## Processo do projeto
1) Entidade
2) Relacionamento
3) Generalização

## Tabelas - Relacionamento
1) n..n: Relacionamento vira tabela.
2) 1..: Adiciona uma coluna quando ter um entidade com cardinalidade máxima um (quem tem o n daí ganha uma coluna.
3) 1..1: POSSÍVEL fazer fusão de tabelas.

## Generalização/Especialização
- ❌ Uma tabela por toda hierarquia.
- ✅ Uma tabela por entidade especializada.
 
