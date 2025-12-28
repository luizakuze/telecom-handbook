# Introdução aos Sistemas Distribuídos 💻

## Escalonamento 

|| Vertical | Horizontal |
| --- | --- |  --- |
| Descrição| Adiciona mais recursos (exemplo: memória) em um único nó | Adição de novos nós no cluster |
|Vantagem | Simpli | Escalável; Tolerância a falhas; Menor custo |
|Desvantagem | Possível limite físico; Custo alto; Se o servidor falhar tudo falha | Complexidade de configuração |

>Exemplo no caso vertical: Você tem uma máquina com 16GB de RAM e melhora ela para 64GB

>Exemplo no caso horizontal: Em vez de uma máquina super potente, você coloca 10 máquinas mais simples em um cluster

## Vantagens STD
- Aplicações naturalmente distribuídas
- Desempenho e escalabilidade
- Operação em larga escala
- Alta disponilidade

## Desafios STD
- Coordenação e comunicação entre múltiplos computadores
- Descoberta de serviços (localizar e acessar)
- Complexidade de desenvolvimento

## Objetivos STD

- Acessibilidade
- Transparência
  - Acesso
  - Localização
  - Desempenho
  - Mobilidade
  - Replicação
  - Concorrência
  - Falhas
- Abertura
- Escalabilidade
- Concorrência

## Técnicas para STD escalável
- Ocultar a latência inerente da comunicação (comunicação assíncrona vs síncrona)
- Distribuição de responsabilidades
- Replicação de componentes

## Topologias de escalabilidade
- Centralizada
- Descentralizada
- Distribuída


|  | Centralizada | Descentralizada | Distribuída |
| -- | -- | -- | -- |
| Coordenação | 1 nó central |  Vários nós coordenadores | Todos os nós colaboram |
| Vantagem | Simples gerenciamento |  Mais resiliente que centralizado | Escalável; Tolerante a falhas |
| Desvatagem | Ponto único de falha | Possíveis gargalos; Mais complexa que a centralizada | Muito complexa |

> A arquitetura centralizada ainda é usada em sistemas pequenos e de baixa demanda. O caminho para o distribuído vem caso a demanda do sistema seja muito alta, caso não seja, pode sofrer com custo alto de configuração e administração do sistema. 