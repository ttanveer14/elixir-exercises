defmodule Vesperia.Cooking.StoreRecipeFinderTest do
  use ExUnit.Case

  alias Vesperia.Cooking.StoreRecipeFinder

  test "recipes available for halure grow from visit 0 to 1" do
    actual_first_visit_recipes = StoreRecipeFinder.recipes_available(:halure, 0)
    actual_second_visit_recipes = StoreRecipeFinder.recipes_available(:halure, 1)

    assert Enum.all?(actual_first_visit_recipes, fn recipe ->
             Enum.member?(actual_second_visit_recipes, recipe)
           end)

    assert actual_first_visit_recipes === [sandwich: %{bread: 1, egg: 1}]
  end

  test "recipes_available/0 successfully returns a non-empty list for zaphias" do
    assert length(StoreRecipeFinder.recipes_available(:zaphias)) > 1
  end
end
