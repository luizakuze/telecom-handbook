// EXERCÍCIO NÃO FINALIZADO

// O programa retira os espaços em excesso de uma string
// Exemplo 1) " luiza    kuze"  ---> "luiza kuze"
// Exemplo 2) "   luiza kuze"   ---> "luiza kuze"

#include <string>
#include <iostream>

using namespace std;

// Função que converte letra para maiúsculo
void string_formata (string & str) {

    for (int i = 0; i < str.size(); i++) {
        if (str[i] == ' ') {

            // Enquanto tiver espaços seguidos
            if (str[i + 1] == ' ') {
                while (str[i + 1] == ' ') {
                    str.erase(i + 1, 1);
                }
            }

            // Se a string começar com espaços
            if (i == 0)
                str.erase(i, 1);
        }


    }
}
int main()
{
    string str;

    getline(cin, str);

    string_formata(str);

    cout << str << endl;

    return 0;
}
