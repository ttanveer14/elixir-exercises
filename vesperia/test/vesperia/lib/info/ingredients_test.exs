defmodule Vesperia.Info.IngredientsTest do
  use ExUnit.Case

  alias Vesperia.Info.Ingredients

  test "ingredients list contains long name ingredients" do
    assert Enum.all?(
             [:napa_cabbage, :dried_seaweed, :sticky_flour],
             &Enum.member?(Ingredients.ingredients(), &1)
           )
  end

  test "ingredients list does not contain malformed ingredient names" do
    assert Enum.all?(Ingredients.ingredients(), fn ingredient ->
             ingredient not in [:napa, :sticky]
           end)
  end

  test "ingredient types are expected values" do
    expected_ingredient_types = Enum.sort([:fish, :meat, :fruit, :vegetable])

    assert Ingredients.ingredient_types()
           |> Enum.sort() === expected_ingredient_types
  end
end
