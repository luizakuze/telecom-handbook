n..n: Vira tabela o relacionamento
n..1: n puxa
id em série

1 Engenheiro(idEng, nome)
2 Projeto(idProj, nome)
3 Atuacao(idEng, idProj, funcao)
4 idEng referencia Engenheiro
5 idProj referencia Projeto

# Exercício 1
Professor(id)
Disciplina(id)
Aluno(id)

Leciona(idProfessor, idDisciplina)
  idProfessor referencia Professor
  idDisciplina referencia Disciplina

Assiste(idDisciplina, idAluno, data, faltas)
  idDisciplina referencia Disciplina
  idAluno referencia Aluno

Prova(id, idDisciplina, idAluno, nota)
  idDisciplina referencia Disciplina
  idAluno referencia Aluno



# Exercício 2
```sql

```


# Exercício 3
```sql

```

# Exercício 4
```sql

```
