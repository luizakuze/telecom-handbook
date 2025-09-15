// Tranforma maiúsculo
// O programa transforma uma string para uma string em letras maiúsculas

#include <iostream>
#include <string>

using namespace std;

int main()
{
    string str;

    getline (cin, str);

    // Transforma caracteres da string para maiúsculo
    for (int i = 0; i < (str).length(); i++) {
        str[i] = toupper(str[i]);
    }

    cout << str;

    return 0;
}
