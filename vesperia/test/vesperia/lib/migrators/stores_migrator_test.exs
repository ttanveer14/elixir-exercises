defmodule Vesperia.Migrators.StoresMigratorTest do
  use ExUnit.Case

  alias Vesperia.Migrators.StoresMigrator

  test """
  when migrating from stores.txt, output ingredients map that
  is the same as the one stored in Vesperia.Info.Stores
  """ do
    expected_map = Vesperia.Info.Stores.ingredients_by_visit()

    actual_map = StoresMigrator.parse_store_lists()

    assert expected_map === actual_map
  end
end
