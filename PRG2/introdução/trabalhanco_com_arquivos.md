## Trabalhando com mais de um arquivo

### Para deixar um código mais limpo, deve se trabalhar com mais de um arquivo na hora de fazer um projeto.

No arquivo chamado *main.cpp*, é mais adequado deixar somente a função "main" <br>
com o objetivo de deixar facilitar o entendimento e tornar o código mais legível.

<img src="https://user-images.githubusercontent.com/111708035/222964263-66298c40-db1f-48ff-8b42-f60f1604f2e3.png" width="40%"/></div>

<br>

As demais funções do programa são colocadas em outro arquivo, por exemplo *funcoes.cpp*.

<img src="https://user-images.githubusercontent.com/111708035/222964259-e1e78293-6db4-4d0f-9f6e-e5a756ebdcbd.png" width="40%"/> <br>

 <br>

Além disso, quando criar esse novo arquivo, também se faz um arquivo de extensão *.h* com a declaração de todas as funções, o protótipo delas. <br> Esse arquivo *.h* deve fazer parte dos includes dos outros 2 arquivos e entre aspas duplas, já que o pré-processador busca pelo arquivo especificado no diretório atual do arquivo fonte que está sendo compilado.

<img src="https://user-images.githubusercontent.com/111708035/222964257-c75bc508-8553-4e08-9fb6-31e73d71acba.png" width="40%"/> <br>