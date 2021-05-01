defmodule Arvore.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :entity_type, :string
      add :inep, :string
      add :parent_id, references(:entities)

      timestamps()
    end

  end
end
