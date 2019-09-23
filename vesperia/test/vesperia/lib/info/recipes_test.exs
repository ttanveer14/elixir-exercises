defmodule Vesperia.Info.RecipesTest do
  use ExUnit.Case

  alias Vesperia.Info.Recipes

  test "recipes map contains long name recipes" do
    assert Enum.all?([:fish_with_miso_sauce], &Enum.member?(Map.keys(Recipes.recipes()), &1))
  end

  test "recipes map does not contain malformed recipe names" do
    actual_recipe_names =
      Recipes.recipes()
      |> Map.keys()

    assert Enum.all?(actual_recipe_names, fn recipe_name -> recipe_name not in [:""] end)
  end

  test "recipe for sushi has correct ingredients and quantities" do
    actual_recipe =
      Recipes.recipes()
      |> Map.fetch!(:sushi)

    expected_recipe = %{fish: 3, dried_seaweed: 1, rice: 1, kelp: 1}

    assert actual_recipe === expected_recipe
  end
end
