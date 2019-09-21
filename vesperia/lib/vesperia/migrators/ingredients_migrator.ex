defmodule Vesperia.Migrators.IngredientsMigrator do
  @ingredients_list "./priv/ingredients.txt"

  def parse_ingredients() do
    @ingredients_list
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> parse_ingredient_groups([])
  end

  defp parse_ingredient_groups([], ingredient_groups), do: Map.new(ingredient_groups)

  defp parse_ingredient_groups(["--" <> _], ingredient_groups), do: Map.new(ingredient_groups)

  defp parse_ingredient_groups(["--" <> _, group_line, "--" <> _ | tail], ingredient_groups) do
    group_name =
      group_line
      |> String.split(" ", parts: 2)
      |> List.first()
      |> String.downcase()
      |> String.to_atom()

    parse_ingredient_groups(tail, [{group_name, []} | ingredient_groups])
  end

  defp parse_ingredient_groups([ingredient_line | tail], [
         {group_name, ingredients} | rest_of_groups
       ]) do
    ingredient =
      ingredient_line
      |> String.split(" ", parts: 2)
      |> List.first()
      |> String.downcase()
      |> String.replace(" ", "_")
      |> String.to_atom()

    parse_ingredient_groups(tail, [{group_name, [ingredient | ingredients]} | rest_of_groups])
  end
end
