# Ferramentas básicas: Ping e Traceroute 🌷

## ☘️ Lista de comandos executados


| Comando                        | Descrição                                                          |
|--------------------------------|--------------------------------------------------------------------|
| `ip a` ou  `ifconfig`          | Mostra as interfaces de rede ativas                                |
| `ifconfig`                     | Repetição do comando ifconfig                                      |
| `ping4 127.0.0.1`              | Testa a conectividade local                                        |
| `ping6 <endereco> `            | Teste de conectividade IPv6                                        |
| `ping <endereco>`              | Envia pacotes ICMP para `<endereco>`                               |
| `man ping`                     | Abre o manual do comando ping                                      |
| `ping <endereco> -c n_counts`  | Envia `n_counts` pacotes ICMP                                      |
| `ping <endereco>  -i interval` | Envia pacotes ICMP com intervalo em segundos (`interval`) definido |
| `ping <endereco>  -s size`     | Envia  pacotes de tamanho definido (`size`)                        |
| `ping <endereco>   -t TTL`     | Envia pacotes ICMP com TTL definido                                |
| `traceroute <endereco>`        | Rastreia a rota até o `<endereco>`                                 |


- Alguns endereços:
  - `www.nasa.com`
  - `www.sorbonne.fr`
  - `www.ifsc.edu.br`


## ☘️ Diferenças IPv4 e IPv6

- **IPv4** e **IPv6** são dois tipos de endereços IP:
  - **IPv4**: São números de 32 bits representados em decimal, exemplo: `172.168.10.1`.
  - **IPv6**: São endereços de 128 bits representados em hexadecimal, exemplo: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`.

## ☘️ Conceitos

- A **máscara de rede** (netmask ou máscara de sub-rede) é usada para dividir o endereço IP em duas partes: a parte de rede (pública)g e a parte dos hosts (sub-rede). Ela é geralmente representada em decimal, exemplo: `255.255.255.0`.

- O **loopback** é o endereço `127.0.0.1`, conhecido como localhost. Ele é usado para se referir à própria máquina dentro de uma rede.

- Os endereços **IPv6** são formados por 8 blocos de 4 dígitos hexadecimais, separados por dois pontos `:`, como no exemplo: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`.

## ☘️ Interfaces de Rede

- **lo (loopback)**: Usada para teste de conectividade e comunicação interna. Com o endereço `127.0.0.1` no IPv4 e `::1` no IPv6, permite que aplicações se comuniquem localmente, sem precisar de uma rede externa. Isso é útil para desenvolvedores testarem suas aplicações de forma segura e eficiente.

- **eth0**: Refere-se a uma interface de rede Ethernet, que é uma conexão com fio. Geralmente, é usada para conectar dispositivos a uma rede local via cabos.

- **wlo1**: Refere-se a uma interface de rede sem fio (wireless), que permite a conexão a redes Wi-Fi. O nome indica que se trata de uma interface wireless, onde a conexão é feita sem cabos.


