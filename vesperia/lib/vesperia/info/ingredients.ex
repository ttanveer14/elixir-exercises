defmodule Vesperia.Info.Ingredients do
  def ingredient_groups do
    %{
      fruit: [:strawberry, :peach, :orange, :kiwifruit, :banana, :apple],
      fish: [:tuna, :squid, :shrimp, :scallop, :salmon, :mackerel],
      meat: [:tuna, :squid, :shrimp, :scallop, :salmon, :pork, :mackerel, :chicken, :beef],
      other: [:tofu, :sticky_flour, :rice, :miso, :milk, :kelp, :egg, :dried_seaweed, :bread],
      vegetable: [
        :tomato,
        :shiitake,
        :radish,
        :potato,
        :onion,
        :napa_cabbage,
        :lettuce,
        :cucumber,
        :carrot,
        :cabbage
      ]
    }
  end

  def ingredients do
    ingredient_groups()
    |> Map.values()
    |> List.flatten()
    |> Enum.uniq()
  end

  def ingredient_types do
    ingredient_groups()
    |> Map.drop([:other])
    |> Map.keys()
  end
end
