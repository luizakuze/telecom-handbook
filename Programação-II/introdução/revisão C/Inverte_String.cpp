// Inversor de String
// O programa imprime uma string invertida

#include <iostream>
#include <string>

using namespace std;

int main()
{
    string str;

    getline (cin, str);

    // Imprime a string invertida
    for (int i = (str).length(); i >= 0; i--)
        cout << str[i];

    return 0;
}
