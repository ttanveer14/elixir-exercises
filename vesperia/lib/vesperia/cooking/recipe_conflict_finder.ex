defmodule Vesperia.Cooking.RecipeConflictFinder do
  @recipes Vesperia.Info.Recipes.recipes()
  @ingredient_types Vesperia.Info.Ingredients.ingredient_types()
  @ingredents_by_type Vesperia.Info.Ingredients.ingredient_groups()

  def choose_recipes([_single_recipe]), do: %{hard_conflicts: %{}, soft_conflicts: []}

  def choose_recipes(recipe_names) when is_list(recipe_names) do
    @recipes
    |> Stream.filter(fn {recipe_name, _ingredients} -> recipe_name in recipe_names end)
    |> Stream.map(fn {_recipe_name, ingredients} -> ingredients end)
    |> Enum.reduce(%{}, fn ingredients, acc ->
      Map.merge(acc, ingredients, fn _ingredient, qty_1, qty_2 -> qty_1 + qty_2 end)
    end)
    |> calculate_soft_conflicts()
    |> calculate_hard_conflicts()
    |> format_conflicts()
  end

  defp calculate_soft_conflicts(%{} = ingredients_and_quantities) do
    recipe_ingredient_types =
      ingredients_and_quantities
      |> Enum.filter(fn {ingredient, _qty} -> ingredient in @ingredient_types end)

    recipe_ingredient_conflicts =
      Enum.map(recipe_ingredient_types, fn {type, _qty} ->
        Enum.filter(ingredients_and_quantities, fn {ingredient, _qty} ->
          ingredient in Map.fetch!(@ingredents_by_type, type)
        end)
      end)

    Map.put(
      ingredients_and_quantities,
      :soft_conflicts,
      recipe_ingredient_types
      |> Stream.zip(recipe_ingredient_conflicts)
      |> Enum.map(fn {type, list} -> Map.new([type | list]) end)
    )
  end

  defp calculate_hard_conflicts(%{} = ingredients_and_conflicts) do
    hard_conflicts =
      ingredients_and_conflicts
      |> Map.drop([:soft_conflicts])
      |> Stream.map(fn
        {ingredient, qty} when qty > 1 -> {ingredient, qty}
        {_ingredient, _one} -> nil
      end)
      |> Enum.reject(&is_nil/1)
      |> Map.new()

    Map.put(ingredients_and_conflicts, :hard_conflicts, hard_conflicts)
  end

  defp format_conflicts(%{hard_conflicts: hard_conflicts, soft_conflicts: soft_conflicts}) do
    %{hard_conflicts: hard_conflicts, soft_conflicts: soft_conflicts}
  end
end
