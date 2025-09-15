# Case e Check

Claro, Luiza! Aqui está o **resumo claro e organizado** do **Laboratório 2.1 – Expressões, Restrições e Transações SQL com SQLite e MySQL**, ideal para caderno, relatório ou repositório:
 
## Expressão `CASE`

Permite testar condições dentro de comandos `SELECT`, `UPDATE`, `DELETE`, `ORDER BY`, `HAVING`, etc.

```sql
CASE expressão
  WHEN valor1 THEN resultado1
  WHEN valor2 THEN resultado2
  ...
  ELSE resultado_padrao
END
```

## Restrições `CHECK`

Permitem validar valores inseridos em colunas. Evitam erros lógicos e garantem integridade dos dados.

* **No nível de coluna:**

```sql
valor INTEGER CHECK(valor > 0)
```

* **No nível da tabela:**

```sql
CHECK(valor > 0 AND desconto <= valor)
```

Exemplo com expressão `CASE` em restrição:

```sql
CHECK(
  CASE
    WHEN sexo = 'M' THEN CASE WHEN reservista IS NOT NULL THEN 1 ELSE 0 END
    ELSE 1
  END
)
```
 

## Transações (BEGIN / COMMIT / ROLLBACK)

Usadas para agrupar operações que devem ocorrer juntas.

* `BEGIN TRANSACTION;` → inicia a transação
* `COMMIT;` ou `END TRANSACTION;` → confirma mudanças
* `ROLLBACK;` → desfaz as alterações
* `SAVEPOINT` / `RELEASE` → pontos intermediários 

**Exemplo de transferência entre contas:**

1. Debita uma conta
2. Credita outra
3. Registra no histórico
4. Finaliza com `COMMIT`


### Alterações com restrições no SQLite

Como o `ALTER TABLE` do SQLite é limitado, para adicionar restrições é necessário:

1. Desativar restrições: `PRAGMA foreign_keys = OFF;`
2. Renomear a tabela antiga
3. Criar nova tabela com restrições
4. Copiar dados
5. Apagar a tabela antiga
6. Encerrar com `END TRANSACTION;`
7. Reativar restrições: `PRAGMA foreign_keys = ON;`
 