## Unidade 3
### Projeto de Estruturas de Dados

No Capítulo 3 do repositório, discutimos o desenvolvimento de estruturas de dados, especificamente a implementação de um array dinâmico e uma tabela hash.

Começamos introduzindo o conceito de um array dinâmico, que permite a alteração da quantidade de dados armazenados, ao contrário de um array estático. Discutimos os requisitos e funcionalidades necessários para essa estrutura, como a alocação dinâmica de memória.

Em seguida, mergulhamos na implementação da estrutura do array dinâmico, usando templates para permitir a generalização do tipo de dados armazenado. Exploramos os atributos da estrutura, como capacidade e contagem de elementos, bem como a alocação dinâmica de memória para armazenar os dados.

Depois, voltamos nossa atenção para a implementação de uma tabela hash, que tem como objetivo criar uma estrutura semelhante a um mapa desordenado. Discutimos a importância de uma boa função de hash, que deve ser computacionalmente eficiente e distribuir os índices uniformemente entre os possíveis valores de saída. Fornecemos exemplos de funções de hash e enfatizamos a necessidade de evitar colisões, onde duas chaves diferentes têm o mesmo índice na tabela.

Discutimos a expansão da tabela, que ocorre quando o tamanho atual atinge o fator de carga. Exploramos o cálculo do fator de carga e a necessidade de expandir a tabela para acomodar novos elementos.

Por fim, discutimos técnicas de tratamento de colisões, destacando o encadeamento como a abordagem escolhida, onde chaves com o mesmo índice são armazenadas em uma lista encadeada. Também mencionamos outras técnicas, como endereçamento aberto com sondagem linear, sondagem quadrática e hash duplo.
