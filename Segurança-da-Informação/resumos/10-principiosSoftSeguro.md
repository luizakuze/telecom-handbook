# Princípios de Projeto Seguro de Software  

## Anotações de alguns princípios
### Mediação Completa
- **Zero Trust**: A cada clique, verificar se o usuário ainda tem direito de acessar.
- Exemplo: SIGAA token de acesso.

### Design Aberto
- A segurança do sistema não deve depender da obscuridade desse sistema.
- Exemplo: Obscuridade em urnas eletrônicas.

### Menor Compartilhamento de Mecanismos
- Evitar compartilhamento desnecessário de recursos.
- Exemplo: Envenenamento de prompt (ex. ChatGPT).

### Aceitabilidade Psicológica
- O sistema não deve ser mais difícil de usar por causa da segurança.

## Testes de Segurança
### Pentest
- Avaliação prática da segurança do sistema.
- Exemplo: Usuário tentando explorar o sistema sem autenticação ou com um usuário de teste.
- **Duplamente cego**: Avalia a equipe de segurança e suas reações a incidentes.

### Testes Estático x Dinâmico
- **Estático**: Durante o desenvolvimento.
- **Dinâmico**: Com o software já finalizado.

### Teste de Regressão
- Garante que novas mudanças no código não introduzam falhas em funcionalidades já existentes.

## SonarQube
- Ferramenta para análise estática de código e identificação de vulnerabilidades.

