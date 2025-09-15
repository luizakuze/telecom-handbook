/* Seu programa deve ler um texto de formulário a partir de um arquivo, preencher as informações indicadas no formulário,
e apresentar o formulário preenchido na tela.

Um formulário é composto por um texto incompleto, com parâmetros correspondendo a valores a serem preenchidos.

Um exemplo de formulário é este:

${cidade}, ${data}
Caro ${aluno}, você foi aprovado em ${disciplina} !


Em um formulário, os parâmetros estão contidos entre chaves e prefixados por $ (ex: ${aluno}). Os nomes de parâmetros são compostos somente por letras ou dígitos numéricos.

Para que seu programa possa ser executado, ele precisa do arquivo de texto com o formulário, e os valores a serem preenchidos nos parâmetros. Isso será feito da seguinte forma:

O nome do arquivo de texto de formulário deve ser informado como primeiro argumento de linha de comando.
Em C++, um arquivo pode ser lido usando um objeto ifstream.

Os valores para os parâmetros devem ser informados via argumentos de linha de comando, como neste exemplo de execução do programa:

aluno@M5:~$ programa arquivo_de_formulario.txt cidade="São José" data="14/02/2020" aluno="Seu Maneca" disciplina="PRG2"

... com isso, o resultado seria este texto:

São José, 14/02/2020
Caro Seu Maneca, você foi aprovado em PRG2 !

ATENÇÃO: seu programa deve ser capaz de preencher um formulário qualquer. O texto de formulário mostrado acima é somente um exemplo. */

#include <iostream>
#include <unordered_map>
#include <string>
#include <fstream>

using namespace std;

int main(int argc, char *argv[]) {

    // Abre arquivo de texto para leitura
    ifstream arq (argv[1]);

    // Verifica se o arquivo abriu corretamente
    if (!arq.is_open()) {
        perror ("Erro ");
        return errno;
    }

    // Cria tabela hash com a chave do campo que deve ser alterado no texto
    // com valor que deve ser alterado no campo como dado
    unordered_map<string, string> alteracao;

    // Lendo chaves e valores da palavra de comando
    for (int i = 2; i < argc; i++) {
        string argumento = argv[i];
        string chave = argumento.substr(0, argumento.find("="));
        string valor = argumento.substr(argumento.find("=") + 1);

        alteracao[chave] = valor;

        //cout << "Chave: " << chave << endl;
        //cout << "Valor: " << valor << endl;
    }

    // Substitui onde encontrar as chaves no texto
    // pelos valores dos dados da tabela hash
    string linha;
    while(getline(arq, linha)) {
        int pos_inicio = linha.find("${");

        while (pos_inicio != string::npos) {
            int pos_fim = linha.find("}", pos_inicio);

            // Se a string não estiver no fim
            if (pos_fim != string::npos) {
                // Extrai uma possível chave da tabela hash sem "${" e '}'
                string chave = linha.substr(pos_inicio + 2, pos_fim - pos_inicio - 2);
                
                // Se houver uma chave na tabela com esse nome,
                // substitui no texto o valor do dado que ela armazena
                if (alteracao.count(chave) > 0) {
                    linha.replace(pos_inicio, pos_fim - pos_inicio + 1, alteracao[chave]);
                    pos_inicio = linha.find("${", pos_inicio + alteracao[chave].size());

                // Se não, procura uma nova palavra com ${
                } else {
                    pos_inicio = linha.find("${", pos_inicio + 1);
                }
                
            // A posição de início não foi encontrada na string    
            } else {
                pos_inicio = linha.find("${", pos_inicio + 1);
            }
        }

        // Imprime a linha do texto formatada
        cout << linha << endl;
    }
    return 0;
}
