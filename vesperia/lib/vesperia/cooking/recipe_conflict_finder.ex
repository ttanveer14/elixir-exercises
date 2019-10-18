defmodule Vesperia.Cooking.RecipeConflictFinder do
  # @recipes Vesperia.Info.Recipes.recipes()
  @ingredients_used_in_recipes Vesperia.Info.Recipes.ingredients_used_in_recipes()
  @ingredient_types Vesperia.Info.Ingredients.ingredient_types()
  @ingredients_by_type Vesperia.Info.Ingredients.ingredient_groups()

  def choose_recipes([_single_recipe]), do: %{hard_conflicts: %{}, soft_conflicts: []}

  def choose_recipes(recipe_names) when is_list(recipe_names) do
    @ingredients_used_in_recipes
    |> Stream.filter(fn {_ingredient, recipes} ->
      Enum.any?(recipe_names, &Map.has_key?(recipes, &1))
    end)
    |> Stream.map(fn {ingredient, recipes} -> {ingredient, Map.take(recipes, recipe_names)} end)
    |> calculate_soft_conflicts()
    |> calculate_hard_conflicts()
    |> Map.take([:soft_conflicts, :hard_conflicts])
  end

  defp calculate_soft_conflicts(ingredients_in_recipes) do
    soft_conflicts =
      ingredients_in_recipes
      |> Stream.filter(fn {ingredient, _recipes} -> ingredient in @ingredient_types end)
      |> Stream.map(fn {ingredient_type, type_recipes} ->
        Enum.reduce(ingredients_in_recipes, %{ingredient_type => type_recipes}, fn
          {ingredient, recipes}, acc ->
            if ingredient in Map.fetch!(@ingredients_by_type, ingredient_type) do
              Map.put(acc, ingredient, recipes)
            else
              acc
            end
        end)
      end)
      |> Enum.reject(fn type -> map_size(type) === 1 end)

    %{
      soft_conflicts: soft_conflicts,
      ingredients_in_recipes: ingredients_in_recipes
    }
  end

  defp calculate_hard_conflicts(ingredients_with_soft_conflicts)
       when is_map(ingredients_with_soft_conflicts) do
    hard_conflicts =
      ingredients_with_soft_conflicts
      |> Map.fetch!(:ingredients_in_recipes)
      |> Stream.reject(fn {_ingredient, recipes} -> map_size(recipes) === 1 end)
      |> Enum.into(%{})

    Map.put(ingredients_with_soft_conflicts, :hard_conflicts, hard_conflicts)
  end
end
