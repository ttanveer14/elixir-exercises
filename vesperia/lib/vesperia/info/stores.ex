defmodule Vesperia.Info.Stores do
  def ingredients_by_visit do
    %{
      aspio: %{0 => [:rice, :onion, :egg, :bread, :beef]},
      aurnion: %{
        0 => [
          :tomato,
          :sticky_flour,
          :shiitake,
          :rice,
          :radish,
          :potato,
          :pork,
          :onion,
          :napa_cabbage,
          :milk,
          :lettuce,
          :egg,
          :cucumber,
          :chicken,
          :carrot,
          :cabbage,
          :beef
        ]
      },
      capua_nor: %{
        0 => [
          :salmon,
          :rice,
          :peach,
          :onion,
          :milk,
          :mackerel,
          :dried_seaweed,
          :bread,
          :beef,
          :apple
        ]
      },
      capua_torim: %{
        0 => [:salmon, :rice, :potato, :peach, :onion, :mackerel, :dried_seaweed, :chicken, :beef]
      },
      dahngrest: %{
        0 => [
          :strawberry,
          :rice,
          :potato,
          :peach,
          :onion,
          :milk,
          :lettuce,
          :egg,
          :cucumber,
          :chicken,
          :bread,
          :beef,
          :apple
        ],
        1 => [:tofu, :radish, :miso],
        2 => [:tomato, :banana],
        3 => [
          :sticky_flour,
          :shiitake,
          :pork,
          :orange,
          :napa_cabbage,
          :kiwifruit,
          :carrot,
          :cabbage
        ]
      },
      deidon_hold: %{0 => [:egg, :bread]},
      ghasfarost: %{
        0 => [
          :tomato,
          :strawberry,
          :rice,
          :peach,
          :onion,
          :milk,
          :lettuce,
          :egg,
          :cucumber,
          :chicken,
          :bread,
          :apple
        ]
      },
      halure: %{
        0 => [:egg, :bread],
        1 => [
          :tomato,
          :sticky_flour,
          :shiitake,
          :rice,
          :radish,
          :potato,
          :pork,
          :onion,
          :napa_cabbage,
          :lettuce,
          :chicken,
          :carrot,
          :cabbage,
          :beef
        ]
      },
      heliord: %{
        0 => [:rice, :potato, :peach, :onion, :miso, :milk, :mackerel, :egg, :chicken, :beef]
      },
      heracles: %{
        0 => [
          :tuna,
          :sticky_flour,
          :squid,
          :shrimp,
          :shiitake,
          :scallop,
          :rice,
          :radish,
          :potato,
          :pork,
          :onion,
          :lettuce,
          :egg,
          :chicken,
          :carrot,
          :bread,
          :beef
        ]
      },
      mantaic: %{
        0 => [
          :sticky_flour,
          :rice,
          :radish,
          :potato,
          :pork,
          :onion,
          :miso,
          :milk,
          :egg,
          :chicken,
          :carrot,
          :cabbage,
          :beef
        ]
      },
      myozoro: %{
        0 => [
          :tofu,
          :sticky_flour,
          :shiitake,
          :rice,
          :radish,
          :potato,
          :pork,
          :onion,
          :napa_cabbage,
          :milk,
          :egg,
          :chicken,
          :carrot,
          :bread,
          :beef
        ]
      },
      nordopolica: %{
        0 => [
          :tuna,
          :tomato,
          :sticky_flour,
          :squid,
          :shrimp,
          :scallop,
          :salmon,
          :pork,
          :onion,
          :milk,
          :mackerel,
          :lettuce,
          :egg,
          :cucumber,
          :chicken,
          :bread,
          :beef
        ],
        1 => [:tofu, :rice, :radish, :potato, :miso, :kelp],
        2 => [:shiitake, :napa_cabbage, :dried_seaweed, :cabbage]
      },
      yormgen: %{
        0 => [
          :tomato,
          :sticky_flour,
          :rice,
          :potato,
          :pork,
          :onion,
          :lettuce,
          :egg,
          :cucumber,
          :chicken,
          :carrot,
          :cabbage,
          :bread,
          :beef
        ]
      },
      zaphias: %{
        0 => [
          :tuna,
          :strawberry,
          :sticky_flour,
          :salmon,
          :rice,
          :potato,
          :pork,
          :peach,
          :onion,
          :milk,
          :mackerel,
          :lettuce,
          :cucumber,
          :chicken,
          :carrot,
          :cabbage,
          :bread,
          :beef,
          :apple
        ]
      }
    }
  end

  def stores(visit_number \\ 3) do
    ingredients_by_visit()
    |> Enum.map(fn {store, sorted_inventory} ->
      {store, consolidate_inventory(sorted_inventory, visit_number)}
    end)
    |> Map.new()
  end

  defp consolidate_inventory(sorted_inventory, visit_number) do
    sorted_inventory
    |> Enum.reduce([], fn
      {visit, _}, acc when visit > visit_number -> acc
      {_, inventory}, acc -> Enum.concat(inventory, acc)
    end)
    |> Enum.uniq()
  end
end
