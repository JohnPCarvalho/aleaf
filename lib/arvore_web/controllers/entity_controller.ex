defmodule ArvoreWeb.EntityController do
  use ArvoreWeb, :controller
  require Logger

  alias Arvore.Leaf
  alias Arvore.Leaf.Entity

  action_fallback ArvoreWeb.FallbackController

  def index(conn, _params) do
    entities = Leaf.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
    with {:ok, %Entity{} = entity} <- Leaf.create_entity(entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.entity_path(conn, :show, entity))
      |> render("show.json", entity: entity)
    end
  end

  def show(conn, %{"id" => id}) do
    entity = Leaf.get_entity!(id)
    parents_id = Leaf.get_parents!(id, entity.entity_type)
    subtree = parents_id.rows
    new_subtree = Enum.map(subtree, fn [ids] -> ids end)

    json(conn, %{
      id: entity.id,
      name: entity.name,
      entity_type: entity.entity_type,
      inep: entity.inep,
      parent_id: entity.parent_id,
      subtree_ids: new_subtree
    })
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = Leaf.get_entity!(id)
    parents_id = Leaf.get_parents!(id, entity.entity_type)
    subtree = parents_id.rows
    new_subtree = Enum.map(subtree, fn [ids] -> ids end)

    with {:ok, %Entity{} = entity} <- Leaf.update_entity(entity, entity_params) do
      json(conn, %{
        id: entity.id,
        name: entity.name,
        entity_type: entity.entity_type,
        inep: entity.inep,
        parent_id: entity.parent_id,
        subtree_ids: new_subtree
      })
      render(conn, "show.json", entity: entity)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = Leaf.get_entity!(id)

    with {:ok, %Entity{}} <- Leaf.delete_entity(entity) do
      send_resp(conn, :no_content, "")
    end
  end
end
