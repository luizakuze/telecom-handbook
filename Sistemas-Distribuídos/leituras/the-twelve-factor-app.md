# The Twelve-Factor APP

> https://12factor.net/pt_br/

- Metodologia para contruir SaaS com 12 diretrizes

## I. Base de Código
- Uma base de código com rastreamento utilizando controle de revisão, muitos deploys
- Um deploy (ou implantação) é uma instância executando a aplicação. 

## II. Dependências
- Declare e isole as dependências
- Exemplo em Python:
  - `pip` para declaração
  - `virtualenv` para isolamento
- Declaração: facilita colaboração e reprodutibilidade
- Isolamento: evita conflitos entre projetos e garante ambientes idênticos em produção, staging e dev (sem conflitos)

## III. Configurações
- Armazene as configurações no ambiente
- Configuração é tudo que pode variar entre deploys (ex. produção, dev, ...)
- Não colocar como constante no código
- Tem que poder expor o código ao público a qualquer momento e não expor credenciais
- Uso de arquivos de configuração não versionados (ex. yaml) é melhor que constantes, porém não o ideal
- O ideal é o uso em variáveis de ambiente (pouca chance de mudar entre deploys)
  
## IV. Serviços de Apoio
- Trate os serviços de apoio, como recursos ligados
- Serviço e apoio: serviço que o app consuma via rede (ex. armazenamento de dados, sistemas de mensagens, serviços SMTP e sistemas de cache)
- Não fazer distinção entre serviço local e serviço de terceiro no código, se quiser trocar é transparente e não altera o código

## V. Construa, lance, execute
- Separe estritamente os builds e execute em estágios
- 3 estágios
  - Construção: `Build`
    - Pega o código fonte de um commit em específico
    - Instala dependências e compila binários.
  - Lançamento: `Release`
    - Combina a construção com a configuração (variáveis de ambiente, credenciais e URLs)
    - Gera um release único e identificado por timestamp ou versão
  - Exeução: `Run`
  - App roda no ambiente de produção (ou staging)
  - 

## VI. Processos
- Execute a aplicação como um ou mais processos que não armazenam estado
- Esses processos são stateless (sem estado) e share-nothing (não compartilham nada entre si)
- O ciclo de vida de um processo deve ser descartável. Pode ser iniciado, parado ou reiniciado sem perda de dados
- Se algo precisar persistir (ex. dados de usuários, sessões, arquivos), isso deve ficar em um serviço externo (ex. DB, Storage, ...)
  
## VII. Vínculo de porta
- Exporte serviços por ligação de porta
- App deve ser auto-contido: ele mesmo abre uma porta de rede para começar a atender requisições
- Ele não deve depender de um servidor externo (ex. Apache ou Tomcat) para abraçar o código

## VIII. Concorrência
- Dimensione por um modelo de processo
- Escalar significa ter mais processos rodando, não apenas aumentar CPU/memória de um único processo.
- 2 tipos de processos:
  - `Web`: Atende requisições HTTP
  - `Workers`: Processam tarefas em background (filas, jobs)

## IX. Descartabilidade
- Maximizar a robustez com inicialização e desligamento rápido
- Processos podem ser iniciados e parados a qualquer momento
- Rápido para subir, seguro para cair.

## X. Dev/prod semelhantes
- Mantenha o desenvolvimento, teste, produção o mais semelhante possível
- Lacunas se manisfestam em 3 áreas: tempo, pessoal e ferramentas
- Desenvolvimento, homologação e produção devem ser o mais iguais possível em tempo, equipe e ferramentas
- Isso reduz incompatibilidades, aumenta confiança em deploy contínuo e deixa o ciclo de vida do app mais robusto
  
## XI. Logs
- Trate logs como fluxo de eventos

## XII. Processos de Admin
- Executar tarefas de administração/gerenciamento como processos pontuais
- Ex. de tarefa: Migração de base de dados
- Deve ser feito em um ambiente idêntico