defmodule Arvore.Leaf do
  @moduledoc """
  The Leaf context.
  """

  import Ecto.Query, warn: false
  alias Arvore.Repo

  alias Arvore.Leaf.Entity

  @doc """
  Returns the list of entities.

  ## Examples

      iex> list_entities()
      [%Entity{}, ...]

  """
  def list_entities do
    Repo.all(Entity)
  end

  @doc """
  Gets a single entity.

  Raises `Ecto.NoResultsError` if the Entity does not exist.

  ## Examples

      iex> get_entity!(123)
      %Entity{}

      iex> get_entity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entity!(id), do: Repo.get!(Entity, id)

  @doc """
  Gets the ids related to the entity by the parent_id field

  Raises `Ecto.NoResultsError` if the Entity does no exist.

  """

  def get_parents!(id, entity_type) do
    cond do
      entity_type == "network" ->
        Ecto.Adapters.SQL.query!(Arvore.Repo, "SELECT id from entities WHERE parent_id = ? AND entity_type = 'school'" , [id])
      entity_type == "school" ->
        Ecto.Adapters.SQL.query!(Arvore.Repo, "SELECT id from entities WHERE parent_id = ? AND (entity_type = 'network' OR entity_type = 'class')", [id])
      entity_type == "class" ->
        Ecto.Adapters.SQL.query!(Arvore.Repo, "SELECT id from entities WHERE parent_id = ? AND entity_type = 'school'" , [id])
    end

  end

  @doc """
  Creates a entity.

  ## Examples

      iex> create_entity(%{field: value})
      {:ok, %Entity{}}

      iex> create_entity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entity(attrs \\ %{}) do
    %Entity{}
    |> Entity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entity.

  ## Examples

      iex> update_entity(entity, %{field: new_value})
      {:ok, %Entity{}}

      iex> update_entity(entity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entity(%Entity{} = entity, attrs) do
    entity
    |> Entity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entity.

  ## Examples

      iex> delete_entity(entity)
      {:ok, %Entity{}}

      iex> delete_entity(entity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entity changes.

  ## Examples

      iex> change_entity(entity)
      %Ecto.Changeset{data: %Entity{}}

  """
  def change_entity(%Entity{} = entity, attrs \\ %{}) do
    Entity.changeset(entity, attrs)
  end
end
