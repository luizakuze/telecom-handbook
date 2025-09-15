## Normaliza o nome 
O programa deixa um nome, por exemplo, dá seguinte forma: "Luiza Kuze" vira "Kuze, Luiza" <br> Ou seja,
o último nome vai para frente

### Implementação do código
```
#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

// Normaliza o nome de uma pessoa
string normaliza(string & nome)
{
    string sobrenome;

    int i;
    int tam_nome = nome.size();

    // Encontra qual é o sobrenome (última palavra)
    for (i = tam_nome - 1; nome[i] != ' '; i--)
        sobrenome = sobrenome + nome[i];

    reverse(sobrenome.begin(), sobrenome.end());

    // Retira o sobrenome do nome completo
    for (i = tam_nome - 1; nome[i] != ' '; i--) {
        nome.erase(i);
    }

    return sobrenome + ", " + nome;

}

int main ()
{
    string nome;

    getline(cin, nome);

    cout << normaliza(nome);

    return 0;
}
```


### Outra lógica para a função "normaliza"
```
#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

// Normaliza o nome de uma pessoa
string normaliza(string nome)
{
    // posição do último espaço
    int pos = nome.rfind(' ');
    
    // Os "::" significam que o tipo string tem o
    // npos declarado em si
    // npos significa "não é uma posição"
    // NEsse caso, significa que não tem o pos, o espaço
    if (pos == string::npos) {
        return "";
    }
    
    // se não informar o quanto quer procurar
    // o substr entende que é até o final da string
    string ultimo = nome.substr(pos+1);
    
    nome = ultimo + ", " + nome.substr(0, pos);
    
    return nome;
}
```
