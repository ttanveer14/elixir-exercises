defmodule Vesperia.Info.StoresTest do
  use ExUnit.Case

  alias Vesperia.Info.Stores

  test "stores list contains long name stores" do
    actual_store_names =
      3
      |> Stores.stores()
      |> Map.keys()

    assert Enum.all?(
             [:capua_nor, :capua_torim, :deidon_hold],
             &Enum.member?(actual_store_names, &1)
           )
  end

  test "stores list does not contain malformed store names" do
    actual_store_names =
      3
      |> Stores.stores()
      |> Map.keys()

    assert Enum.all?(actual_store_names, fn store_name ->
             store_name not in [:capua, :""]
           end)
  end

  test "dahngrest inventory grows from visits 0 (first visit) to 3" do
    [
      actual_first_visit_inventory,
      actual_second_visit_inventory,
      actual_third_visit_inventory,
      actual_fourth_visit_inventory
    ] =
      Enum.map([0, 1, 2, 3], fn visit ->
        visit
        |> Stores.stores()
        |> Map.fetch!(:dahngrest)
      end)

    assert length(actual_second_visit_inventory) > length(actual_first_visit_inventory)
    assert length(actual_third_visit_inventory) > length(actual_second_visit_inventory)
    assert length(actual_fourth_visit_inventory) > length(actual_third_visit_inventory)

    assert Enum.all?(
             actual_first_visit_inventory,
             &Enum.member?(actual_fourth_visit_inventory, &1)
           )
  end
end
