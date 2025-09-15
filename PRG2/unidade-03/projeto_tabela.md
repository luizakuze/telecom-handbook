## Anotações projeto - Tabelas Hash

### Objetivo
Implementar uma estrutura de dados semelhante ao **unordered map**.

### Função Hash
Tem os seguintes requisitidos de implementação:
- Ser leve computacionalmente.
- Espalhar uniformemente os índices entre todos os possíveis valores de saída.

Além dos requisitos, teremos que a posição do dado vai ser calculada a partir da seguinte fórmula:
```
hN(k)= k mod N
```
Onde **mod**, significa o resto da divisão e **K** um int.

- Exemplificando em uma função:
```
unsigned int hash(const string &  chave, unsigned int N) {
  unsigned int total = 0;

  for (auto & c: chave) total += c;

  return total % N;
}
```

- Outro exemplo: <br>
  string s = "ABC" ----> em ASCII 65 = A, 66 = B e 67 = C <br>
  Sendo N = 32, <br>
  (65 + 66 + 67) = 198 ---> 198 mod 32 = 6 <br> <br>

Essa não é uma boa solução, pois causa muitas colisões em uma parte da tabela. <br>

- **A solução mais simples:**
```
unsigned int hash_simples(const string & chave, int N) {
    unsigned int soma = 0;

    for (auto & c: chave) {
      // desloca 8 bits p esquerda do valor anterior da soma
      soma = ((soma << 8) + c) % N; 
    }
    return soma % N;  
}
```
- A **Fletcher32** também é uma boa opção, um algoritmo que já existe.

---

### Expansão da tabela

A tabela é expandida sempre que o tamanho atual da tabela for igual ao fator de carga. <br>
Esse fator pode ser obtido a partir da seguinte razão:

- **Fator de Carga:** Tamanho / número de linhas <br>

Número de linhas = "buckets"

Se procurar na biblioteca do C++, tem um tópico "buckets" da "unordened_map". <br>
Onde podemos encontrar o valor dele em uma tabela real.

---

## Tratamento de Colisão
Colisão é quando o hash é calculado e a posição calculada é a mesma para a chave. <br>
__"Acontece quando duas chaves diferentes tem o mesmo índice da tabela."__ <br>

Existem algumas abordagens que auxiliam no tratamento de colisões, a **criptografia hash**, por exemplo, é utilizada para gerar chaves eletrônicas e assinaturas digitais.

- **Abordagem escolhida** Ao invés de guardar um par de chave e valor, guardar em uma lista.
  Consequências -> Busca linear para encontrar o dado adicional, pq agra vai ter uma lista e não diretamente o dado. Aqui, é  visível a necessidade de uma boa função hash, já que os dados tem que ser bem separados para não ficar uma lista muito grande em uma única coluna da tabela (muito custoso para percorrer essa coluna).

Poderia ser a lista ou o vector, mas a lista otimiza o código. Último dado que o usuário acessar, vai para o início da tabela hash. Algunas dados são mais utilizados que outros.

Algumas técnicas para evitar colisçoes:

### Endereçamento Aberto
1 - Função hash para identificar a linha da tabela onde armazenar uma chave
2 - Caso essa linha esteja ocupada, ela procura uma posição alternativa na tabela (isso pode ser feito mais de uma vez)
3 - Caso não encontre uma posição alternativa, a tabela é considerada cheia, e deve ser expandida


**-> Sondagem Linear**

Calcula o hashing, se tiver ocupado armazena na próxima linha. Funciona como fila circular. <br>
Caso percorrer todas as linhas e não encontrar um local livre, fala que a tabela está cheia.


**-> Sondagem Quadrática**

Como a sondagem linear, mas caso a linha esteja ocupada ela calcula a nova posição a partir de um polinômio quadrático.


**-> Hashing Duplo**

Duas funções hash para calculo da nova posição. <br> Um pouco melhor que as anteriores. <br> <br>


## Encadeamento x Endereçamento Aberto
- **Encadeamento** = Tabelas reais.
- **Endereçamento Aberto** = Quando há pouca memória disponível.
