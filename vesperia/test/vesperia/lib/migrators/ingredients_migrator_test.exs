defmodule Vesperia.Migrators.IngredientsMigratorTest do
  use ExUnit.Case

  alias Vesperia.Migrators.IngredientsMigrator

  test """
  when migrating from ingredients.txt, output ingredients map that
  is the same as the one stored in Vesperia.Info.Ingredients
  """ do
    expected_map =
      Vesperia.Info.Ingredients.ingredient_groups()
      |> Map.drop([:fish])

    actual_map = IngredientsMigrator.parse_ingredients()

    assert expected_map === actual_map
  end
end
