# O que é um container Linux?

> https://www.redhat.com/pt-br/topics/containers/whats-a-linux-container

- Um conjunto de processos isolados do resto do sistema
- Inclui todos os arquivos necessários (dependências, libs, binários) dentro de uma imagem
- Por isso, é portátil e consistente entre desenvolvimento, teste e produção

## Benefícios
- Reduz conflitos entre ambientes (dev, homologação, produção)
- Portabilidade: roda em data centers, nuvem pública, privada ou híbrida
- Mais rápido que VMs tradicionais para empacotar e entregar aplicações
- Permite separar responsabilidades: devs cuidam da aplicação, ops da infraestrutura

## LXC e Docker
- LXC (Linux Containers): tecnologia inicial de containers no Linux.
- Docker (2008): popularizou o modelo com imagens em camadas, repositórios e CLI simples.

## Containers vs máquinas virtuais
- VMs: mais pesadas, isolam hardware, boas quando você precisa de ambientes totalmente diferentes (ex.: Linux e Windows no mesmo host).
- Containers: leves, isolam processos, ótimos para escalar aplicações rapidamente e trabalhar com microsserviços.

## Segurança
- Containers não são “seguros por padrão”.
- É preciso integrar práticas de segurança no pipeline (DevSecOps).
- Uso de assinaturas de imagens, varredura de vulnerabilidades, isolamento e políticas de acesso.

## Kubernetes
- Gerenciamento de múltiplos containers
- Autimatizar deploy, escala e monitoramento