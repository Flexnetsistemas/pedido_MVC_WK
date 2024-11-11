
# Projeto para Teste Técnico WK Technology

Este projeto foi desenvolvido como parte do avaliação técnica para a WK Technology. O objetivo é aplicar as técnicas de Programação Orientada a Objetos (POO), Modelo-Visão-Controle (MVC), Clean Code e boas práticas de desenvolvimento. O projeto é um formulário de pedidos.

## Tecnologias Utilizadas

- Delphi 12 (Componentes nativos)
- MySQL (Banco dados, config.ini)
- Padrões de design: POO, MVC, Clean Code

## Estrutura do Projeto

O projeto está organizado em camadas distintas, seguindo o padrão MVC, com a persistência de dados separada em uma camada de DAO (Data Access Object). Abaixo estão as principais pastas e arquivos do projeto:

### Camada de **View** (Interface com o Usuário)
- **Vendas.View.pas**: Responsável pela interface gráfica com o usuário, onde são feitas as interações com o sistema.

### Camada de **Controller** (Controle de Fluxo)
- **Controller.Conexao.pas**: Responsável pela conexão com o banco de dados.
- **Controller.Pedido.pas**: Lida com a lógica de controle dos pedidos.

### Camada de **Model** (Estruturas de Dados)
- **Model.Cliente.pas**: Define a estrutura de dados e regras de negócios relacionadas aos clientes.
- **Model.Pedido.pas**: Representa a estrutura de dados e as regras de negócios relacionadas aos pedidos.
- **Model.Produto.pas**: Define a estrutura de dados e as regras de negócios para os produtos.

### Camada de **Persistência de Dados (DAO)**
- **DAOConexao.pas**: Responsável pela implementação da conexão com o banco de dados MySQL.
- **DAOPedidos.pas**: Implementa as operações de persistência relacionadas aos pedidos.

### Banco de Dados

O banco de dados necessário para o funcionamento do projeto está descrito no script presente na pasta `BDados/`. O script é responsável por criar as tabelas e a estrutura necessária no MySQL, os parametros de conexao com banco esta definida no arquivo config.ini na mesma pasta do executável.

## Como Rodar o Projeto

### Requisitos

- **Delphi (10.3 ou superior)**
- **MySQL**: Instalar e configurar um banco de dados MySQL local ou remoto.
- **FireDAC**: Componente de conexão dom banco de dados.

### Passos

1. **Configuração do Banco de Dados:**
   - Importe o script SQL localizado na pasta `BDados/` para o seu servidor MySQL.
   - O script cria as tabelas

2. **Configuração do Projeto:**
   - Abra o projeto no Delphi
   - Certifique-se de que a conexão com o banco de dados MySQL está configurada corretamente no arquivo config.ini
   
3. **Executando o Projeto:**
   - Após configurar a conexão com o banco de dados, compile e execute o projeto.
   - A interface gráfica estará disponível no arquivo **Vendas.View.pas**.


## Funcionalidades

O sistema oferece as seguintes funcionalidades:

1. **Novo Pedido:**
   - O usuário pode criar um novo pedido, selecionando um cliente pelo código e adicionando itens ao pedido.
   - O sistema permite que o usuário adicione novos produtos ao pedido, especificando a quantidade e o valor de cada item.

2. **Consulta de Pedidos:**
   - O usuário pode consultar os pedidos existentes, pelo número do pedido, visualizando os detalhes como o cliente associado, os itens do pedido e o valor total.

3. **Excluir Pedido:**
   - É possível excluir um pedido existente, removendo o pedido e seus itens do banco de dados.

4. **Selecionar Cliente pelo Código:**
   - Ao criar um pedido, o usuário pode selecionar um cliente pelo código. Isso permite que o sistema associe o pedido a um cliente existente no banco de dados.

5. **Adicionar Produto pelo Código:**
   - Durante a inclusão de itens no pedido, o usuário pode digitar o código do produto  ira trazer a quantidade padrao 1 e o valor de cadastro do produto. O sistema automaticamente calcula o valor total do item, baseado no preço do produto e na quantidade inserida.

6. **Incluir e Alterar Itens no Pedido:**
   - O sistema permite incluir um item na lista de itens do pedido e, ao mesmo tempo, fazer alterações diretamente nos componentes de inclusão.
   - Caso o item já exista, ao incluir de novo, o sistema atualiza a quantidade e o valor do item existente na grid.

7. **Alterar Quantidade e Valor do Item:**
   - O usuário pode alterar a quantidade e o valor dos itens do pedido diretamente clicando na grid, e fazer alterações diretamente nos componentes de inclusão.

8. **Excluir Item do Pedido:**
   - O usuário pode excluir itens do pedido, removendo-os da lista de itens na grid, tecla delete

9. **Soma do Total no Rodapé:**
   - O total do pedido é calculado automaticamente e exibido no rodapé da tela. Ele soma os valores de todos os itens do pedido, levando em conta a quantidade e o valor unitário de cada item.

10. **Validações de Entrada:**
    - O sistema realiza validações de entrada para garantir que todos os dados necessários sejam preenchidos corretamente:
      - Validação de campos obrigatórios (como código do produto, quantidade e valor).
      - Validação para garantir que a quantidade inserida
      - Validação para garantir que o valor do item seja um número válido.
      - Validação do cliente selecionado, antes da salvar o pedido.

### Autor
---
<a href="https://www.flexnetsistemas.com.br/">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/65642299?s=60&amp;v=4" width="100px;" alt=""/>
 <br />
 <sub><b>Ricardo de Assis</b></sub></a> <a href="https://www.flexnetsistemas.com.br/" title="Flexnet">🚀</a>

[![Linkedin Badge](https://img.shields.io/badge/-Ricardo-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/ricardo-de-assis-dev/)](https://www.linkedin.com/in/ricardo-de-assis-dev/) 
[![Gmail Badge](https://img.shields.io/badge/-rdassis@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:rdassis@gmail.com)](mailto:rdassis@gmail.com)
