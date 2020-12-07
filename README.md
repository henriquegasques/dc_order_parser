# OrderPayloadParser

Aplicação criada como solução para teste https://bitbucket.org/delivery_center/test-dev-backend-elixir/src/master/

### Para subir a aplicação

Instalar as dependências com:
`mix deps.get`

Preparar o banco de dados:
`mix ecto.create`
`mix ecto.migrate`

Rodar os testes:
`mix test`

Subir o servidor:
`mix phx.server`

### Endpoints

#### Criação de pedido

`POST http://localhost:4000/api/orders`

