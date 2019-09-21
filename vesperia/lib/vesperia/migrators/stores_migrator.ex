defmodule Vesperia.Migrators.StoresMigrator do
  @stores_list "./priv/stores.txt"

  def parse_store_lists do
    @stores_list
    |> File.stream!()
    |> Enum.map(&String.trim(&1, "\n"))
    |> mapify_stores([])
  end

  defp mapify_stores([], store_lists), do: Map.new(store_lists)

  defp mapify_stores(["__" <> _, store_name_line | rest], store_lists) do
    store_name =
      store_name_line
      |> String.split("--", parts: 2)
      |> List.first()
      |> String.trim()
      |> String.downcase()
      |> String.replace(" ", "_")
      |> String.to_atom()

    mapify_stores(rest, [{store_name, %{}} | store_lists])
  end

  defp mapify_stores([ingredients_line | rest], [{store_name, inventory} | rest_store_lists]) do
    updated_inventory =
      ingredients_line
      |> String.split(",")
      |> Enum.map(&String.trim(&1, " "))
      |> Enum.reject(fn item -> item === "" end)
      |> sort_by_visit(inventory)

    mapify_stores(rest, [{store_name, updated_inventory} | rest_store_lists])
  end

  defp sort_by_visit([], inventory), do: inventory

  defp sort_by_visit([ingredient_with_stars | rest], inventory) do
    visit_number = how_many_stars?(ingredient_with_stars)

    ingredient =
      ingredient_with_stars
      |> String.trim("*")
      |> String.replace(" ", "_")
      |> String.downcase()
      |> String.to_atom()

    sort_by_visit(
      rest,
      Map.update(inventory, visit_number, [ingredient], fn ingredients ->
        [ingredient | ingredients]
      end)
    )
  end

  defp how_many_stars?(ingredient_with_stars) do
    ingredient_with_stars
    |> String.codepoints()
    |> Enum.filter(fn codepoint -> codepoint === "*" end)
    |> length
  end
end
