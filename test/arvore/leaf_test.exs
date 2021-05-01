defmodule Arvore.LeafTest do
  use Arvore.DataCase

  alias Arvore.Leaf

  describe "entities" do
    alias Arvore.Leaf.Entity

    @valid_attrs %{entity_type: "some entity_type", inep: "some inep", name: "some name"}
    @update_attrs %{entity_type: "some updated entity_type", inep: "some updated inep", name: "some updated name"}
    @invalid_attrs %{entity_type: nil, inep: nil, name: nil}

    def entity_fixture(attrs \\ %{}) do
      {:ok, entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Leaf.create_entity()

      entity
    end

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Leaf.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Leaf.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      assert {:ok, %Entity{} = entity} = Leaf.create_entity(@valid_attrs)
      assert entity.entity_type == "some entity_type"
      assert entity.inep == "some inep"
      assert entity.name == "some name"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Leaf.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{} = entity} = Leaf.update_entity(entity, @update_attrs)
      assert entity.entity_type == "some updated entity_type"
      assert entity.inep == "some updated inep"
      assert entity.name == "some updated name"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Leaf.update_entity(entity, @invalid_attrs)
      assert entity == Leaf.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Leaf.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Leaf.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Leaf.change_entity(entity)
    end
  end
end
