| Ícone               | Significado                                  | Descrição                                                                 | Exemplo (tabela)     |
|---------------------|----------------------------------------------|---------------------------------------------------------------------------|-----------------------|
| 🔑 Chave amarela    | Chave primária (PRIMARY KEY)                 | Identifica unicamente cada registro. Não pode repetir nem ser nula.      | `idPessoa` (Pessoa)   |
| 🔑 Chave vermelha   | Chave estrangeira (FOREIGN KEY)              | Referencia chave primária de outra tabela. Cria relacionamentos.         | `idAgencia` (Conta)   |
| 🔷 Losango vermelho | Parte de chave primária composta             | É chave primária **e** estrangeira. Usado em tabelas de associação.      | `idConta` (Correntista) |
| 🔷 Losango azul      | Atributo comum                               | Campo de dado sem restrições de chave. Pode conter qualquer valor.       | `nome` (Pessoa)       |
