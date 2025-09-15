# Projeto 2 - Descobrindo rotas em um mapa 🚗

## Objetivo 📌
Encontrar a melhor rota possível entre duas cidades em um mapa.

- Seu programa deve exibir a melhor rota possível entre duas cidades. A rota deve ser apresentada como uma sequência de cidades desde a origem até o destino, juntamente com a distância total da viagem. As cidades devem ser inseridas através do teclado, e o resultado deve ser exibido na tela.

## Descrição 📘
Suponha que haja um mapa, como podemos representá-lo no programa para facilitar a descoberta de caminhos? Uma ideia é representar um mapa como uma tabela que fornece informações sobre cada par de locais e a distância entre eles.

Por exemplo, considere este mapa com algumas cidades próximas a Florianópolis:

| Cidade 1  | Cidade 2	| Distância (km) |
|------------------------| --- |----------------|
| Florianópolis          | São José	| 19             | 
| Florianópolis	         | Biguaçu	| 24             |
| São José	              | Biguaçu	| 20 |               
| São José	              | Palhoça	| 6 |                
| São José	              | São Pedro de Alcântara |	22 |
| Biguaçu                |	Antônio Carlos             |	17 |
| São Pedro de Alcântara	 | Antônio Carlos	| 10             |

Uma vez que essa tabela exista, como um programa pode calcular uma rota entre duas cidades? Basicamente, ele precisa usar um algoritmo de busca de caminhos no mapa. O algoritmo SPF, criado por Dijkstra, pode ser usado neste projeto.
