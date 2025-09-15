## Árvores

### Conceitos
- Árvore Binária: Cada elemento tem no máximo dois ramos.
- Grau: Número de ramos que se estendem a partir de um elemento.
- O explorador de arquivos pode ser entendido como uma estrutura de árvore. No caso do Linux, a raiz seria o diretório inicial "/".
- Uma árvore deve ter um ponto inicial.
- É um tipo de grafo.

### Necessidades
Pesquisa Aproximada. <br> Quando decisões bidirecionais precisam ser tomadas em cada ponto de um processo.

### Funcionamento
A árvore de busca binária funciona com base em duas ideias principais:

- Valores menores vão para o ramo esquerdo.
- Valores maiores vão para o ramo direito.
É importante observar que, para strings, "valores menores" se referem a valores anteriores na ordem alfabética, e "valores maiores" se referem a valores subsequentes.

### Biblioteca
A biblioteca STL não fornece uma implementação genérica de árvore de busca binária. <br>
Neste curso, foi utilizada uma biblioteca implementada pelo professor.