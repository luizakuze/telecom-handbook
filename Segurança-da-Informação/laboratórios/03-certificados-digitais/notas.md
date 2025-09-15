# Laboratório 2

- Colocar servidor no ar www com https
- Para https precisa do certificado digital


mkdir primeiro
cd primeiro/
ls
    5  touch Dockerfile
    6  touch nginx.conf
    7  mkdir html
    8  mkdir -p ssl/{certs,private}
    9  touch html/index.html
   10  history

Servidores web:
Apache httpd
Nginx


private -> chave (permissao de osmente leitura, nginx precisa p comunicação)
certs -> certificados 

1. criar certificados + chave
o certificado é autoassinado, vai ter a msg de erro no navegador... assinado p hcave privada propria 

gerando chave c algoritmo rsa
openssl genrsa -out private/server.key 2048
criando certificado
openssl req -x509 -new -key private/server.key -out certs/server.crt -days 365

aluno: ssl$ openssl req -x509 -new -key private/server.key -out certs/server.crt -days 365
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:BR
State or Province Name (full name) [Some-State]:SC
Locality Name (eg, city) []:Sao Jose
Organization Name (eg, company) [Internet Widgits Pty Ltd]:IFSC
Organizational Unit Name (eg, section) []:campus SJE
Common Name (e.g. server FQDN or YOUR name) []:localhost
Email Address []:e@example.org

mostrando certificado
openssl x509 -in certs/server.crt -text -noout
note que issuer e subject tem mesmos campos, é autoassinado

fazendo dockerfile...
fazendo nginx...
80 e ?
443 https

fazendo html...
docker build -t servidor-ssl .
docker images
servidor ssl está lá

parte 2 lab
autoriadde certificadora, só add ela e não dá mais a msg de erro

nao cria certificado, somente faz o pedido do certificado passo 4


---

java keytool
