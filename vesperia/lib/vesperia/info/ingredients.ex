defmodule Vesperia.Info.Ingredients do
  def ingredients do
    %{
      fruit: [:strawberry, :peach, :orange, :kiwifruit, :banana, :apple],
      fish: [:tuna, :squid, :shrimp, :scallop, :salmon, :mackerel],
      meat: [:tuna, :squid, :shrimp, :scallop, :salmon, :pork, :mackerel, :chicken, :beef],
      other: [:tofu, :sticky, :rice, :miso, :milk, :kelp, :egg, :dried, :bread],
      vegetable: [
        :tomato,
        :shiitake,
        :radish,
        :potato,
        :onion,
        :napa,
        :lettuce,
        :cucumber,
        :carrot,
        :cabbage
      ]
    }
  end
end
