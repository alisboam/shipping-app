# Project
Esta é a aplicação responsável por gerenciar a frota de entrega para um e-commerce com alcance nacional. Diferentes tipos de transporte são cadastrados definindo as cidades de atuação, os prazos e os custos. A plataforma deve cadastrar novos pedidos de frete (ordens de serviço) e fazer os cálculos de frete de acordo com os tipos de transporte que atendem ao perfil do pedido. Além disso deve ser possível controlar as ordens de serviço em andamento, encerrar ordens de serviço e consultar o status da frota de veículos da empresa.

https://www.notion.so/be251a29f2f140c7a135cdf422dccb5d?v=9ad19de8d60742fa8805497672dc4563

## Instalação

### Clone o repositório

```shell
git clone git@github.com:alisboam/shipping-app.git
cd shipping-app
```

### Verifique sua versão do Ruby

```shell
ruby -v
```

Caso não esteja atualizado, instale através do [rbenv](https://github.com/rbenv/rbenv) (esta ação pode demorar um pouco):

```shell
rbenv install
```

### Instale as dependências

Usando [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

### Configurando o projeto
Rode os seguintes comandos parar criar o banco de dados:

```ruby
rails db:create
rails db:migrate
rails db:seed 
```

##### Inicie o servidor

```ruby
rails s
```

Abra no navegador http://localhost:3000

##### Melhorias de projeto

- [ ] Validação de intervalos já cadastrados
- [ ] Formatação de valores nos formulários
- [ ] Paginação


