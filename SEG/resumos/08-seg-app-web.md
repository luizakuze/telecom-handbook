# Segurança em Aplicações Web

## Prática
```sh
docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop
```

---

## SQL Injection

- Exemplo de ataque:
  ```sql
  admin' or 1=1 --
  ```
- **Problema**: Não podemos confiar na entrada do usuário, pois ele pode injetar código SQL malicioso para manipular o banco de dados.
- **Soluções**:
  - Consultas parametrizadas.
  - Uso de frameworks ORM (ex: Hibernate, JPA).
  - Sanitização das entradas do usuário.
  - Segmentação de permissões de acesso ao banco (mínimo de privilégios necessários).
  - **Conceitos do banco**: ACID e BASE.

---

## Cookies

- O servidor envia cookies ao cliente, e nas próximas requisições, o cliente os envia de volta.
- **Tipos de cookies**:
  - **Persistente**: Permanece armazenado mesmo após desligar o computador, até a data de expiração.
  - **De sessão**: Excluído automaticamente ao fechar o navegador.
- **Recomendação**: Preferir IndexedDB ao invés de cookies por questões de privacidade.

---

## Roubo de Sessão

- O atacante pode roubar o cookie de sessão de um usuário autenticado por meio de interceptação de tráfego de rede, XSS, entre outros métodos.
- **Mitigações**:
  - Sempre utilizar **HTTPS** (impede interceptação de tráfego).
  - Alterar o cookie de sessão após a autenticação do usuário.
  - Definir um tempo de expiração curto para a sessão.

---

## Sequestro de Cliques (Clickjacking)

- O usuário é induzido a clicar em algo sem perceber.
- **Prevenção**:
  - Utilizar o cabeçalho **X-Frame-Options**.
  - Implementar **frame-busting** com JavaScript.
  - Configurar o cabeçalho **Content-Security-Policy (CSP)**.

---

## Cross-Site Scripting (XSS)

- Injeção de código arbitrário em um site confiável, executando tanto a aplicação original quanto código malicioso.
- **Tipos**:
  - **Refletido (não persistente)**: A carga maliciosa é enviada e retornada na mesma requisição.
  - **Armazenado (persistente)**: O código malicioso é salvo no servidor e afeta múltiplos usuários.
  - **Baseado em DOM**: A manipulação ocorre diretamente na árvore DOM do usuário.
- **Prevenção**:
  - Sanitizar a entrada do usuário.
  - Utilizar **Content-Security-Policy (CSP)** para restringir fontes de conteúdo carregadas na página.

---

## CSRF (Cross-Site Request Forgery)

- Permite que ações sejam executadas em um site onde o usuário está autenticado, sem seu consentimento.
- **Exemplos**: SIGAA, Juice Shop.
- **Prevenção**:
  - Uso de **tokens de requisição**.
  - Configuração do **SameSite** em cookies.
  - Verificação de origem da requisição.
  - Evitar o uso de **GET** para modificar o estado do servidor; utilizar **POST, PUT, DELETE** (seguindo a ideia do REST).