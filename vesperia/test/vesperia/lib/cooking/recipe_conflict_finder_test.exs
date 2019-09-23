defmodule Vesperia.Cooking.RecipeConflictFinderTest do
  use ExUnit.Case

  alias Vesperia.Cooking.RecipeConflictFinder

  test "recipes for sorbet, pudding, cake, and crepe yield expected conflicts" do
    expected_conflicts = %{
      hard_conflicts: %{milk: 4, egg: 3},
      soft_conflicts: [%{fruit: 1, strawberry: 1, kiwifruit: 1, banana: 1}]
    }

    assert RecipeConflictFinder.choose_recipes([:sorbet, :pudding, :cake, :crepe]) ===
             expected_conflicts
  end

  test """
  recipes that require multiple ingredients (salisbury steak, sukiyaki)
  show correct quantity conflicts
  """ do
    expected_conflicts = %{hard_conflicts: %{beef: 3, egg: 2}, soft_conflicts: []}

    assert RecipeConflictFinder.choose_recipes([:salisbury_steak, :sukiyaki]) ===
             expected_conflicts
  end

  test "choosing single recipe returns no conflicts" do
    expected_conflicts = %{soft_conflicts: [], hard_conflicts: %{}}

    actual_conflicts =
      Vesperia.Info.Recipes.recipes()
      |> Map.keys()
      |> Enum.random()
      |> List.wrap()
      |> RecipeConflictFinder.choose_recipes()

    assert actual_conflicts === expected_conflicts
  end
end
