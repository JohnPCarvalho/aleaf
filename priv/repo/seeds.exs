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

Arvore.Leaf.create_entity(%{name: "Colégio Objetivo", entity_type: "network", inep: nil, parent_id: nil })
Arvore.Leaf.create_entity(%{name: "SESI", entity_type: "network", inep: nil, parent_id: nil })
Arvore.Leaf.create_entity(%{name: "Colégio Objetivo Monte Alto", entity_type: "school", inep: "123-300", parent_id: 1 })
Arvore.Leaf.create_entity(%{name: "Colégio Objetivo Rio de Janeiro", entity_type: "school", inep: "123-2", parent_id: 1 })
Arvore.Leaf.create_entity(%{name: "SESI - Unidade São Paulo", entity_type: "school", inep: "1211", parent_id: 2 })
Arvore.Leaf.create_entity(%{name: "COC", entity_type: "network", inep: nil, parent_id: nil })
Arvore.Leaf.create_entity(%{name: "COC - Rio", entity_type: "school", inep: "998", parent_id: 6 })
Arvore.Leaf.create_entity(%{name: "Turma 3A", entity_type: "class", inep: nil, parent_id: 6 })
