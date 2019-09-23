defmodule Vesperia.Migrators.RecipesMigratorTest do
  use ExUnit.Case

  alias Vesperia.Migrators.RecipesMigrator

  test """
  when migrating from vesperia-recipes-effects.txt, output recipes map that
  is the same as the one stored in Vesperia.Info.Recipes
  """ do
    expected_map = Vesperia.Info.Recipes.recipes()

    actual_map = RecipesMigrator.parse_recipes()

    assert expected_map === actual_map
  end
end
