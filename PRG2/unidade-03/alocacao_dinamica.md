## Alocação de Memória

- **Estática** <br>
  O compilador sabe quanta memória cada tipo de dados precisa, e por isso reserva a quantidade adequada para cada variável.

- **Dinâmica** <br>
  Não se sabe a quantidade de dados que serão armazenados.


<div align="center">

<img align="center" width="500px" src="https://github.com/luizakuze/Prog2/assets/111708035/7d9206fe-7afc-4d13-b230-d8fecb98a397">

</div>

<br>

### Memória <br>
- **Stack** <br> Onde as variáveis são guardadas e parâmetros de funções.

- Heap <br> Onde se faz a alocação dinâmica de memória. No heap, o progamador tem controle da quantidade de memória, só tendo o armazenamento possível da máquina como limite.

```
Anotação dos comentários da aula: 

- "1<<20"
Significa que vai voltar 20 posições do num.

- bzero(mem, size);
Escreve zeros no "mem", na quantidade size.
```

### Área de memória não está alocada, mensagem:

O próprio processador é quem dispara o erro. O próprio Linux aqui decide qual a máxima de memória da pilha.

Quando funções chamam outras funções, pode cair nesse erro. Pois cada chamada de função, é preciso alocar mais memória ("StackOverflow")

**Testes na pilha:**
<div align="center">

<img align="center" width="500px" src="https://github.com/luizakuze/Prog2/assets/111708035/b22d319e-ab80-4607-aae1-bc52ac123e3b">

</div>

<br>

**Testes no heap (heap aloca mais memória):**

<div align="center">

<img align="center" width="500px" src="https://github.com/luizakuze/Prog2/assets/111708035/aea42518-a640-42f3-8ee2-1e5ee58516db">

</div>


### Como funciona para alocar memória dinamicamente

**Heap**
<div align="center">

<img align="center" width="500px" src="https://github.com/luizakuze/Prog2/assets/111708035/dda8053b-2ee2-41b2-b771-4f0abbe4d516">

</div>

<br>

**Stack**
<div align="center">

<img align="center" width="500px" src="https://github.com/luizakuze/Prog2/assets/111708035/80dd8bb4-ae05-4702-a11f-6cb7f161b193">

</div>

<br>



Não é possível realocar a memória (expandir ela). Somente criar outro espaço e copiar todos os elementos p esse novo espaço q deve ter mais memória disponível.


---

### Sintaxe ponteiros e memória

- **Em C++**
  <br> Usual:
  _int x;_          <br>
  Criando dinamicamente: _int * p = new int;_ <br>(new significa "aloque memória dinâmicamente na quantidade de dados necessária").


- **Em C** <br>
  _int * = (int*)malloc(sizeof(int));_


- **Em C++** <br>
  Usual: _int v[10];_ <br> Dinamicamente:
  _int * pv = new int[10];_



- **Em C** <br>
  _int * = (int*)malloc(10*sizeof(int));_
```
Anotações da forma dinâmica:
- Aloca memória;
- Inicializa a área de memória se tiver a instrução.
```