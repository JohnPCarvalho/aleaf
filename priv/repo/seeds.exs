# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Arvore.Repo.insert!(%Arvore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

IO.puts("Adding a couple of items...")

Arvore.Leaf.create_entity(%{name: "Colégio Objetivo", entity_type: "network", inep: "123", parent_id: nil })
Arvore.Leaf.create_entity(%{name: "SESI", entity_type: "network", inep: "321", parent_id: nil })
Arvore.Leaf.create_entity(%{name: "Colégio Objetivo Monte Alto", entity_type: "school", inep: "123-300", parent_id: 1 })
Arvore.Leaf.create_entity(%{name: "Colégio Objetivo Rio de Janeiro", entity_type: "school", inep: "123-2", parent_id: 1 })
Arvore.Leaf.create_entity(%{name: "SESI - Unidade São Paulo", entity_type: "school", inep: "321-1", parent_id: 2 })
