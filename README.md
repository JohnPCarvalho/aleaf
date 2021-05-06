# Árvore Backender Test

* Autor: Johnny Paulino de Carvalho
*  Desafio: Construir uma API visando permitir  a um parceiro da Árvore replicar sua estrutura de Redes, Escolas e Turmas

------------

O projeto foi desenvolvido utilizando a linguagem de programação [Elixir](https://elixir-lang.org/ "Elixir"), juntamente com o framework [Phoenix](https://www.phoenixframework.org/ "Phoenix") para a criação/desenvolvimento da API.

Requisitos Mínimos:
- [x] Documentação do repositório git;
- [x] Histórico de commits;
- [x] Testes unitários;

Requisitos Desejáveis:
- [x] - Deploy em qualquer serviço para consumo durante avaliação

Ferramentas:
* Elixir: 1.10.4 
* Erlang/OTP: 23.1.1
* Phoenix: 1.5.8
* MySQL: 8.0.24

Clone o repositório com o seguinte comando:

`git clone git@github.com:JohnPCarvalho/aleaf.git`

Com o repositório em sua máquina, entre na pasta `aleaf`

```    
cd aleaf/
```

Primeiramente, é necessário ter uma instância do MySQL pronta para uso, para poder consumir a base de dados, é necessário configurar os parâmetros para conexão dentro do projeto.

Dentro da pasta do projeto, na pasta `config `, abra os arquivos `dev.exs` e `test.exs ` e edite da seguinte maneira:

`dev.exs`:
```elixir
config :arvore, Arvore.Repo,
  username: <seu_usuario>,
  password: <sua_senha>,
  database: "arvore_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

`test.exs`
```elixir
config :arvore, Arvore.Repo,
  username: <seu_usuario>,
  password: <sua_senha>
  database: "arvore_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

```

Para iniciar seu servidor Phoenix:

* Instale as dependências com ` mix deps.get `
* Crie e migre sua base de dados com `mix ecto.setup`
* Inicie o servidor com `mix phx.server`
* Para executar os testes unitários:`mix test`

Obs: dentro do projeto, na pasta ` priv/seeds.exs `, há um arquivo para alimentar a base com alguns dados de início, ao rodar o comando ` mix ecto.setup` ou `mix ecto.reset`, o arquivo será lido, e os dados inseridos.

Agora você pode começar a consumir os endpoints no endereço `localhost:4000/api/entities`

## Deploy

O deploy da aplicação foi feito utilizando Google Cloud Services composto de uma instância VM com Debian 10, e uma instância de banco de dados como serviço utilizando MySQL na versão especificada.

Obs: Esta estrutura atende apenas como ambiente de testes. Em ambientes de produção, o recomendado é utilizar clusterização, com load balancer.

Para consumir os endpoints da aplicação, basta acessar o seguinte endereço e seguir os modelos de requisição dentro da seção [Endpoints](##Endpoints)

http://justaleaf.hopto.org:4000/api/entities


------------

## Endpoints 
Para o consumo dos endpoints é possível utilizar ferramentas como o [Postman](https://www.postman.com/ "Postman") ou o [Insomnia](https://insomnia.rest/download "Insomnia") ou diretamente com `curl ` via terminal.

- Criação de  entidade (entity):

http://localhost:4000/api/entities
POST request: 

```json
{
    "entity": {
        "name": "COC - Unidade SP",
        "entity_type": "school",
        "inep": "050213",
        "parent_id": 1
    }
}
```
Response:
```json
{
    "data": {
        "entity_type": "school",
        "id": 8,
        "inep": "050213",
        "name": "COC - Unidade SP",
        "parent_id": 1
    }
}
```

------------

- Edição de uma entidade (entity): 

http://localhost:4000/api/entities/7    onde 7 é o id passado para a alteração
PUT request:
```json
{
    "entity": {
        "name": "COC - Unidade Rio",
        "entity_type": "school",
        "inep": "123132
        "parent_id": 6
    }
}

```

Response:
```json
{
    "entity_type": "school",
    "id": 7,
    "inep": "123132
    "name": "COC - Unidade Rio",
    "parent_id": 6,
    "subtree_ids": []
}
```

------------

- Exibição de uma entidade (por id)

GET request:
http://localhost:4000/api/entities/6 onde 6 é o id passado para pesquisa
```json
{
    "entity_type": "network",
    "id": 6,
    "inep": null,
    "name": "COC",
    "parent_id": null,
    "subtree_ids": [
        7
    ]
}
```
