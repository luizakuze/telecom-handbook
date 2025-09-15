## Resumo dos Comandos - MySQL
| Seção                              | Comando                                                                 |
|------------------------------------|-------------------------------------------------------------------------|
| Ativar MySQL no sistema (Ubuntu)   | sudo systemctl start mysql                                              |
| Instalação no Ubuntu               | sudo apt-get install -y mysql-server mysql-client                       |
| Subir MySQL com Docker             | docker run --rm -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=senhaRoot ...    |
| Acessar shell do contêiner         | docker exec -it meumysql bash                                           |
| Cliente MySQL no contêiner         | docker exec -it meumysql mysql -u aluno -p                              |
| Cliente MySQL no host              | mysql -u aluno -paluno                                                  |
| Cliente MySQL como root            | mysql -u root -psenhaRoot                                               |
| Parar/Iniciar contêiner            | docker stop meumysql / docker start meumysql                            |
| docker-compose                     | docker compose start                                                    |
| Codificação UTF-8                  | mysql> charset utf8;                                                    |
| Autocomplete                       | mysql> \#                                                               |
| Sair do MySQL                      | exit / quit / Ctrl+D                                                    |
| Registrar sessão                   | tee labmysql-registro.txt / notee                                       |
| Criar banco                        | CREATE DATABASE lab;                                                   |
| Criar usuário                      | CREATE USER 'aluno'@'%' IDENTIFIED BY '1234';                           |
| Conceder permissões                | GRANT ALL ON lab.* TO 'aluno'@'%';                                      |
| Mostrar bancos                     | SHOW DATABASES;                                                         |
| Usar banco                         | USE lab;                                                                |
| Ver estrutura da tabela            | DESC Aluno;                                                             |
| Ver comando de criação             | SHOW CREATE TABLE Aluno;                                               |
| Script interativo                  | source lab.sql                                                          |
| Script pela shell                  | mysql lab < lab.sql -u aluno -p                                         |
| Backup do banco                    | mysqldump lab -u aluno -p > backup-lab.sql                              |


### Acessar o Cliente MySQL e Operações Básicas

#### 1. Acessar o Cliente
```bash
mysql -u aluno -p
```

#### 2. Criar um Banco de Dados
```sql
CREATE DATABASE lab;
```

#### 3. Usar o Banco Criado
```sql
USE lab;
```

#### 4. Criar Tabelas
```sql
CREATE TABLE NomeTabela (
    -- Defina as colunas e tipos de dados aqui
);
```

#### 5. Listar Tabelas Existentes
```sql
SHOW TABLES;
```

#### 6. Ver Estrutura da Tabela
```sql
DESC NomeTabela;
```

#### 7. Inserir Registros
```sql
INSERT INTO NomeTabela (colunas) VALUES (valores);
```

#### 8. Ver Registros
```sql
SELECT * FROM NomeTabela;
```


## Resumo dos Comandos – SQLite
| Seção                              | Comando                                                                 |
|------------------------------------|-------------------------------------------------------------------------|
| Instalar SQLite (Ubuntu)           | sudo apt-get install -y sqlite3                                         |
| Criar/Abrir banco                  | sqlite3 meu_banco.db                                                    |
| Usar banco                         | Já está usando ao abrir o arquivo `.db`                                |
| Listar tabelas                     | .tables                                                                 |
| Ver estrutura da tabela            | .schema NomeDaTabela                                                    |
| Ver todo o schema do banco         | .schema                                                                 |
| Criar tabela                       | CREATE TABLE Aluno (id INTEGER PRIMARY KEY, nome TEXT, email TEXT);    |
| Inserir dados                      | INSERT INTO Aluno (nome, email) VALUES ('Ana', 'ana@email.com');       |
| Listar dados                       | SELECT * FROM Aluno;                                                   |
| Executar script SQL                | .read arquivo.sql                                                       |
| Sair do SQLite                     | .exit                                                                   |
| Mostrar comandos internos          | .help                                                                   |
| Limpar a tela                      | (use Ctrl+L no terminal)                                                |
| Ver versão                         | sqlite> SELECT sqlite_version();                                       |



### Acessar o Cliente SQLite3 e Operações Básicas

#### 1. Iniciar o SQLite3 com um Banco de Dados
```bash
sqlite3 meu_banco.db
```
*Nota: O banco será criado automaticamente se não existir.*

#### 2. Criar Tabelas
```sql
CREATE TABLE NomeTabela (
    -- Defina as colunas e tipos de dados aqui
);
```

#### 3. Listar Tabelas Existentes
```sqlite
.tables
```

#### 4. Ver Estrutura da Tabela
```sqlite
.schema NomeTabela
```

#### 5. Inserir Registros
```sql
INSERT INTO NomeTabela (colunas) VALUES (valores);
```

#### 6. Ver Registros
```sql
SELECT * FROM NomeTabela;
```
