defmodule Vesperia.Migrators.RecipesMigrator do
  @recipes_list "./priv/vesperia-recipes-effects.txt"

  def parse_recipes() do
    @recipes_list
    |> File.stream!()
    |> Stream.map(&parse_recipe_name/1)
    |> Stream.reject(&is_nil/1)
    |> Enum.reject(fn line -> line in [:-, :""] end)
    |> mapify_recipes([])
  end

  defp parse_recipe_name("///" <> _tail) do
    nil
  end

  defp parse_recipe_name("_" <> _tail) do
    nil
  end

  defp parse_recipe_name("  " <> tail) do
    parse_ingredients(tail, String.contains?(tail, "--"))
  end

  defp parse_recipe_name(line) do
    line
    |> String.split("--", parts: 2, trim: true)
    |> Enum.at(0)
    |> String.trim_trailing()
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  defp parse_ingredients(_, false), do: nil

  defp parse_ingredients(line, true) do
    line
    |> String.split("--", parts: 2, trim: true)
    |> Enum.at(0)
    |> String.trim()
    |> String.split(",", trim: true)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.downcase/1)
    |> Stream.map(&String.split(&1, "(", trim: true))
    |> Enum.map(&ingredient_and_qty/1)
  end

  defp ingredient_and_qty([ingredient]) do
    {atomify(ingredient), 1}
  end

  defp ingredient_and_qty([ingredient, qty]) do
    {atomify(ingredient), get_number(qty)}
  end

  defp atomify(ingredient) do
    ingredient
    |> String.trim()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  defp get_number(qty) do
    qty
    |> String.codepoints()
    |> Stream.filter(fn char -> String.contains?("0123456789", char) end)
    |> Enum.at(0)
    |> String.to_integer()
  end

  defp mapify_recipes([], keyword_list), do: Map.new(keyword_list)

  defp mapify_recipes([_dog_food], keyword_list), do: Map.new(keyword_list)

  defp mapify_recipes([recipe_name, ingredient_list | rest], keyword_list) do
    mapify_recipes(rest, [{recipe_name, Map.new(ingredient_list)} | keyword_list])
  end
end
