# Project
Esta é a aplicação responsável por gerenciar a frota de entrega para um e-commerce com alcance nacional. Diferentes tipos de transporte são cadastrados definindo as cidades de atuação, os prazos e os custos. A plataforma deve cadastrar novos pedidos de frete (ordens de serviço) e fazer os cálculos de frete de acordo com os tipos de transporte que atendem ao perfil do pedido. Além disso deve ser possível controlar as ordens de serviço em andamento, encerrar ordens de serviço e consultar o status da frota de veículos da empresa.

https://www.notion.so/be251a29f2f140c7a135cdf422dccb5d?v=9ad19de8d60742fa8805497672dc4563

## Install

### Clone the repository

```shell
git clone git@github.com:alisboam/shipping-app.git
cd shipping-app
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.0.0`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Install dependencies
Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
rails db:seed 
```

##### Start Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000