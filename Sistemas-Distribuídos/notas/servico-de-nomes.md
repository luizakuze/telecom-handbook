# Serviço de Nomes (DNS)

## Conceitos Gerais

- **IPs públicos** são únicos globalmente.
- **IPs privados** podem se repetir em redes diferentes.
- **Identificadores**:
  - Telefone **não** é identificador verdadeiro.
  - Placa de carro **é** identificador verdadeiro.

## URI, URL e URN

- **URL** e **URN** são tipos de **URI**.
- **URN**:
  - Não indica localização.
  - Possui um **espaço de nomes**.
- **URL**:
  - Indica localização e método de acesso.

## Portas e HTTP

- HTTP usa a **porta 80** por padrão.
- Por isso, normalmente não é necessário informar a porta na URL.

## Nome vs IP

- Usar **nome em vez de IP**:
  - **Desempenho**: não há ganho relevante.
  - **Usabilidade**: grande vantagem.
- No primeiro acesso:
  - O nome é resolvido via DNS.
  - Depois, fica em **cache**, evitando nova resolução.

## Tipos de Nomes

- **Nome puro**: não contém informação de localização.
- **Nome não puro**: contém informação de localização.

## DNS

- Escopo **global e hierárquico**.
- Hierarquia:
  - **IANA**: gerencia o nível raiz (`.`).
  - **Registro.br**: gerencia domínios `.br`.

## Resolução de Nomes no Linux

### Ordem de Resolução
```bash
cat /etc/nsswitch.conf
```

### Hosts Locais
```bash
/etc/hosts
```

### Servidores DNS
```bash
cat /etc/resolv.conf
```

- Consulta o DNS primário; se falhar, tenta o secundário.
- DHCP informa o DNS.
- Busca FQDN + sufixos de `search`.

## Resolução Recursiva vs Iterativa

- DNS local: **recursivo**
- DNS externos: **iterativo**

## Servidores Raiz

- **13 servidores DNS raiz**
- Redundância e **round-robin**

## UUID

- Similar à **chave Pix**
- Usado como **chave primária**

## BIND

- Mínimo de **2 servidores**
- Serial deve ser incrementado a cada mudança

### Cache e TTL

- TTL alto: propagação lenta
- TTL baixo: sobrecarga

## Comandos `dig`

```bash
dig -x 200.135.190.2
dig www.ifsc.edu.br
dig www.google.com.br
dig slack.com.br
dig +trace www.ifsc.edu.br
dig NS ufsc.br
```