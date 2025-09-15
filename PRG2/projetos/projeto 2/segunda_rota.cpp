/* Após implementar um algoritmo que encontra a melhor rota e a melhor distância entre duas cidades de um arquivo csv,
o problema inicial do projeto foi solucionado.

Agora, como uma melhoria de projeto, foi questionado como encontraríamos uma segunda melhor rota. Fiz uma função que faz isso.
Essa função como se fosse um algoritmo de dijkstra, assim como a função já existente anteriormente no projeto. 
O objetivo era que com pequenas modificações na função anterior, ela encontraria uma segunda melhor rota (quando existente).
Caso não exista uma segunda opção de caminho, a primeira e a segunda melhor rota são iguais.

A minha implementação não funciona completamente. Ela segue uma abordagem gulosa (greedy),
em que escolhe a melhor opção imediata a cada etapa do algoritmo.
O que depende da estrutura do problema pra funcionar: se o resultado a cada etapa não depende de decisões futuras, então pode funcionar.
Mas não é o caso da busca de melhor caminho, pois uma próxima etapa analisada pode oferecer uma melhor solução do que a atual. 

Como não havia mais tempo para realizar o projeto, mantive a minha implementação dessa forma.

Para usufruir dos resultados dessa função, é necessário utilizar as funções que já existiam antes no projeto. Dessa forma: 
****************
    // Calcula e imprime a segunda melhor rota encontrada na segunda melhor tabela dijkstra
    tabela_dijkstra = dijkstra2(mapa, destino);
    cout << endl << "Segunda melhor rota: " << melhor_rota(tabela_dijkstra, partida, destino) << endl;
    cout << "Distancia: " << melhor_distancia(tabela_dijkstra, partida) << " km" << endl;
****************
*/

// Função que implementa a lógica do algoritmo de dijkstra e retorna uma tabela com os SEGUNDOS MELHORES valores encontrados.
// Recebe como parâmetros: Uma tabela hash contendo as relações de distâncias entre as cidades
// e uma string contendo qual a cidade de destino do usuário.
unordered_map<string, nodo> dijkstra2(unordered_map<string, list<adjacente>>& mapa, const string& destino) {

    // Cria a tabela dijkstra para segunda melhor rota
    unordered_map<string, nodo> tabela_dijkstra;

    // Cria uma lista para armazenar os nodos da tabela dijkstra
    list<string> nodos;

    // Lê as cidades/nodos para dentro da lista "nodos"
    for (auto & cidade : mapa) {
        nodos.push_back(cidade.first);
    }

    // Inicializa a tabela dijkstra
    for (auto & nodo : nodos) {
        tabela_dijkstra[nodo] = {INT_MAX, ""};
    }
    tabela_dijkstra[destino] = {0, destino};

    // Extrai da lista nodos o nodo com menor distância até o nodo destino
    while (!nodos.empty()) {
        string nodo_atual;
        int menor_distancia = INT_MAX;

        // Encontra o nodo com menor distância da origem até o destino
        for (auto & nodo : nodos) {
            if (tabela_dijkstra[nodo].custo < menor_distancia) {
                menor_distancia = tabela_dijkstra[nodo].custo;
                nodo_atual = nodo;
            }
        }

        // Encontra o nodo com segunda menor distância
        int segunda_menor_distancia = INT_MAX;
        for (auto &nodo: nodos) {
            if (tabela_dijkstra[nodo].custo < segunda_menor_distancia &&
                tabela_dijkstra[nodo].custo > menor_distancia) {
                segunda_menor_distancia = tabela_dijkstra[nodo].custo;
            }
        }


        // Para cada nodo adjacente do nodo com menor distância:
        for (auto & adj : mapa[nodo_atual]) {
            // Calcula a distância do nodo adjacente
            int distancia = tabela_dijkstra[nodo_atual].custo + adj.distancia;

            // Se a distância encontrada for menor do que a distância atual do nodo:
            if (distancia < tabela_dijkstra[adj.cidade].custo) {
                tabela_dijkstra[adj.cidade] = { distancia, nodo_atual };
            }

            // Se a distância encontrada for menor que a segunda menor distância e maior que a menor distância:
            else if (distancia < segunda_menor_distancia && distancia > menor_distancia) {
                // Atualiza a segunda melhor distância do nodo adjacente
                tabela_dijkstra[adj.cidade].custo = distancia;
                tabela_dijkstra[adj.cidade].procedente = nodo_atual;
            }
        }

        // Remove o nodo atual da lista de nodos não visitados
        nodos.remove(nodo_atual);
    }

    return tabela_dijkstra;
}
