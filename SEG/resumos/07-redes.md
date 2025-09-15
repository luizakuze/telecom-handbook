# Segurança em Redes de Computadores

## Conceitos Fundamentais

### Equipamentos de Rede
- **Switch**: Opera na camada de enlace, funcionando apenas em redes locais.
- **Roteador**: Atua na camada de transporte, possibilitando a comunicação entre diferentes redes.
- **Firewall**: Define se um pacote pode ou não entrar em uma rede.

### Endereçamento IP e MAC
- **IP de destino + portas**: Define para onde o pacote será enviado.
- **MAC é invariável, enquanto IP é variável dentro da rede.**
- **Pacotes para fora da rede local** são enviados pelo **gateway**.
- **Exemplos de roteamento:**
  - **Rede local:** `192.168.0.0/24` → comunicação interna.
  - **Destino fora da rede local:**
    - **IP privado:** `192.168.2.1` → enviado ao gateway, mas não acessa a internet.
    - **IP público:** `8.8.8.8` → gateway encaminha para a internet.
- **IP origem e máscara de rede:**
  - Exemplo: `192.168.0.1/24`, onde os **três primeiros octetos** permanecem fixos.
  - Comando `route -n` para visualizar rotas.

### Sistemas Autônomos e Distribuição de IPs
- **Sistema Autônomo (AS)**: Controla uma rede de forma independente.
- **Órgãos que distribuem IPs:**
  - **IANA** e **ICANN**: Organismos globais.
  - **Registro BR**: Gerencia IPs no Brasil.
- **Faixas de IPs privados:**
  - `192.168.X.0/24` → Bloco C (máximo de 253 máquinas).
  - `172.16.X.X/16` → Mais endereços disponíveis.
  - `10.X.X.X/8` → Faixa ainda maior.

## NAT (Network Address Translation)

### Exemplo de Envio de Pacote
1. **Origem:** `192.168.0.10`
2. **Destino:** `8.8.8.8`
3. **NAT traduz o IP privado para um IP público ao enviar o pacote.**

### Exemplo de Resposta
1. **Origem:** `8.8.8.8`
2. **Destino:** (NAT traduz de volta para `192.168.0.10`, a origem não sabe qual esse IP pois é privado)

## Interceptação de Pacotes
- **Na origem**: Malware na máquina local.
- **Na rede local**: Ataque Man-in-the-Middle (MITM).
- **No roteador**: Mais fácil de interceptar (exemplo: LAN → PC Linux → Roteador).
- **Na rede destino** e **no próprio destino**.

## Restrições de Acesso
- **Para garantir que um servidor seja acessado apenas na rede local:**
  - Deve usar **IP privado**.
  - Se um PC utilizar **IP público**, um **firewall pode bloqueá-lo** (exemplo: IFSC).
- **Acesso remoto entre redes locais:**
  - Exemplo:
    - Máquina 1: `192.168.0.10:8080`
    - Máquina 2: `10.0.0.10`
    - **Uso de IP público e IP forwarding.**
  - Para descobrir o IP público: `https://ifconfig.me/`
- **Verificação de dono de IP:**
  - `whois 191.36.13.27`
- **Garantir acesso apenas para máquinas autorizadas:**
  - Filtragem de acesso por **MAC** ou **IP**.
  - Uso de **firewall local** ou **firewall de rede**.

## Distribuição de IPs na Rede
- **Para evitar conflitos de IP:**
  - **Configuração estática**.
  - **Uso de DHCP** (distribuição automática pelo roteador).

## ARP (Address Resolution Protocol)
- No **IPv4**, ARP resolve endereços MAC a partir de um IP.
- Se um dispositivo nunca foi encontrado antes, ele será armazenado no **cache ARP** por um tempo.
- **Ataque ARP Spoofing**: Um invasor pode falsificar um endereço MAC.
- No **IPv6**, é utilizado outro protocolo para essa função.

## DNS (Domain Name System)
- **Comandos úteis:**
  - `dig www.google.com.br` → Resolve o nome para IP.
  - `cat /etc/resolv.conf` → Exibe o DNS configurado.
  - `dig +short www.google.com.br` → Exibe apenas o IP.
- **Funcionamento:**
  1. O **servidor DNS resolver** do IFSC processa a consulta.
  2. Se não encontrar no cache, consulta a **raiz do DNS** (existem 13 servidores principais no mundo).
  3. Tipos de resolução:
     - **Recursiva**: Cliente pergunta e recebe uma resposta definitiva.
     - **Iterativa**: Servidores DNS informam a próxima etapa a seguir. Quando aponta p servidor específico da UFSC.
- **TTL (Time To Live):**
  - Comando `watch dig www.google.com.br` para observar mudanças no cache DNS.
- **Exemplo de consultas específicas:**
  - `dig @191.36.8.66 www.google.com.br` → Consulta direta a um servidor DNS.
  - `dig NS sj.ifsc.edu.br` → Descobre servidores responsáveis por um domínio.

## Testes de Resolução de Nomes
- **Consulta ao servidor da UFSC:**
  ```sh
  dig @150.162.242.74 www.ufsc.br
  ```
- **Consulta ao IFSC pelo servidor da UFSC:**
  ```sh
  dig @150.162.242.74 www.ifsc.edu.br
  ```
  - Não funciona, pois o domínio **ifsc.edu.br não é gerenciado pela UFSC**.
 
---

## Firewall

- Possibilita acesso aos sistemas externos e mantém acessos não autorizados fora do perímetro.

- Analisa pacote enviado e permite responder.

- Deve ser só "firewall" para diminuir a superfície de ataque, muitas vezes é invisível a rede.

## Locais para colocar o firewall

### Firewall de máquina
- Perímetro é a máquina local
- Usuário ou SO entrega as regras de quem pode acessar
- Importante analisar as entradas e saídas. Algum processo que está na própria máquina pode ser malicioso.
- Windowns Firewall: VSCode precisa baixar extensões, aparece firewall. Boa proteção, mas usabilidade é ruim. 

Para ubuntu: ufw. comando iptables. 

### FIrewall de rede
- Perímetro é a rede local
- Vê tudo que entra e sai da rede: Analisa ips, portas e protocolo de transporte

---

Em casa é o local também para fazer traduções de endereços de rede também NAT.

Não protege de ataques da rede interna

Nao pode permitir colocar um usb e virar uma interface de rede.

###
- Importante combinar firewall pessoal e de rede.

- Portas em uso: netstat -tln. Se mandar pacotes da rede local para esses ips, vai conseguir desde q seja da rede local

### Tipos
- Filtro de pacotes (Rede): Olha para cabeçalho, no roteador de casa. Muito rápido. O ruim é a usabilidade
- Inspeção de estado (Transporte): Olha quem tá enviando pra fora e deixa outro responder para ele. Evita ataques elaborados, mas o ruim é que não atende o UDP
- Gateway no nível de aplicação (Aplicação): Tráfego na aplicação. + custoso, devagar para fazer. Analisa se é mp3, exz,...Granulas, mas precisa de processamento.
- Web Application Firewall (WAF): Aplicações web, ver variáveis, script no lugar correto,.. Hospedar na nuvem. Para tráfego HTTP. Proteção SQL injection, XSS, CSRF e DoS

```shell
# Descobrindo porta do ssh>
grep ssh /etc/services
# Verificando se a porta está "aberta" para conexões locais
netstat -tln
```

Permite tráfego 80 ou 443: Não permite usuário já navegar na internet, pois porta 53 estará bloqueada pelo DNS

A volta ele permite por conta do TCP.

---

## Local 

O local do firewall pode afetar implementação

- Local
- Roteador/Firewall (casa)
- Firewall com 2 interfaces (ifsc)
- Firewall com subredes (se 1 das subredes tiver um malware, não se propaga para as outras subredes) (na borda da rede)
- 2 Firewalls com subredes (borda da rede e entre as subredes)

---

## Estação Bastião
- Passa pelo proxy entre firewall e computadores. É transparente. Proxy intercepta o tráfego, pode servir para bloquear determinados sites.

---

## Organização da rede

- Somente estações de trabalho ou estações e servidores internos: Tudo bem 1 firewall

Problema dee ter 1 firewall na borda somente> Estações, servidores internos e externos. Regra que deixe pacotes entrar sem ter enviado. Problema: Pode ganhar acesso aos serviços internos que não deveria.
É precio segmentar, a zona desmilitarizada.

### Zona Desmilitarizada
- Equipamentos que precisa ser acessados pela rede, mas que comprometidos não afetal local
- Ex. corredor entre as coreias
- Exemplo: DNS infectado apontando para site malicioso. Solução: DNS interno

---


### Ataques

#### Interceptação de trpafego

- ``Sniffing``: Fácil de fazer. Interceptar, capturar e analisar dados em uma rede, por meio no wireshark, tcpdump, ettercap e kismet. Ataque passivo o que deixa ele ser difícil de interceptar. Mitigar: Ciptografia: VPN, HTTPS, SSH e criptografia de ponta a ponta.

- ``Spoofing``: Um pouco mais difícil que sniffing. Falsificação de identidade para enganar dispositivos em uma rede. Ataqeu ativo, atacante participa da comunicação. MITM
  - ARP Spoofing: Manipula ARP para redirecionar tráfego. Todos enxergam a pergunta referente a quem é o gateway (broadcast), apenas gatwway responde (broadcast), atacante responde por cima (broascast tbm) e os outros  atualizam tabela de cache e ofusca o gateway por um determinado tempo.
  _ARP qual MAC associado ao IP_

  - IP Spoofing: Falsifica IP para mascarar atacante. ifconfig da máquina do lado, se vc assumir ess eip com a outra maquina desligada, vc se passa por essa marquina. (rede local) Para rede diferentes é mais dificil

- `DNS poising`: Consultas para envenenar cache do DNS. Na primeira pergunta, ainda quando nao tem cache, envenena e faz sempre redirecionar para servidor do atacanate.
  - Se não tivre o DNSSEC, é fácil de acontecer. O DNSSC ainda não é muito adotado (proposta de 2005)
  - dig NS ifsc.... 
  - dig NS adns....rnp do ifsc
  - dig TXT ufsc.com.br
  - software malicioso geralmente altera arquivo de host


- `Sequestro de BGP`:

  - _BGP para trocar info. de roteameo entre AS._
  - Fácil AS's afirmarem terem rotas falsas com prefixos de ip

- `DoS`: Negação de serviço, afeta disponibilidade. O mais comum `IP Spoofing`
bcp.nic.br/antispoofing, pq o spoofing ainda existe. ex pode contecer se nao forjar seguranca de pacotes qeu saem ambem, atacante inventa origem.Manda pacoet para quem nem perguntou, atacante faz isso c milhares de maquinas e responde para 1 enlace 1 maquina e por reflexao dewrruba aquela maquina. O atacante faz pequenos pacotes e as maquinas infectadas repondem com grandes respostas.

- `DrDoS - Amplificacao de DNS`: ,ta indo com o dig, grande qt bytes. TXT grande passa por várias consultas recursivas.

- `SYN FLood`: Camada de transporte. 3 way handshake. Vários SYN sem esperar o SYN+ACK do receptor. Fácil de mitigar. Ataque volumetrico

- `Slowloris`: Alvo servidor web. Atacante nao precisa de muito recurso. Muitas conexoes aberta.

--- 

## VPN
- Acesso remoto, site a site ou pessoal.
- Rede privada sobre rede pública.
