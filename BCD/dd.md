2.2 Criando um banco de dados e dando todas as permissões para um novo usuário
mysql> CREATE DATABASE lab;
-- Criando usuário aluno, com a senha '1234' e delegando todos direitos sobre o banco 'lab'
mysql> CREATE USER IF NOT EXISTS 'aluno'@'%' IDENTIFIED WITH mysql_native_password by '1234';
mysql> GRANT ALL ON lab.* TO 'aluno'@'%';

Concetando esse aluno
mysql -u aluno -paluno
ou
mysql -h 127.0.0.1 -u aluno -p

sempre use nomeDAtabase pra conseguir usar
