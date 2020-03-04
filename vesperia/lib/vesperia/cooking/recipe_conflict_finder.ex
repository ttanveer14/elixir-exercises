defmodule Vesperia.Cooking.RecipeConflictFinder do
  @recipes Vesperia.Info.Recipes.recipes()
  @ingredients_used_in_recipes Vesperia.Info.Recipes.ingredients_used_in_recipes()
  @ingredient_types Vesperia.Info.Ingredients.ingredient_types()
  @ingredients_by_type Vesperia.Info.Ingredients.ingredient_groups()

  def find_conflicts(user_input) do
    with {:ok, recipe_names} when is_list(recipe_names) <- parse_input(user_input),
         {:ok, %{hard_conflicts: _, soft_conflicts: _} = conflicts} <-
           choose_recipes(recipe_names) do
      {:ok, conflicts}
    else
      {:error, msg} -> {:error, msg}
    end
  end

  def parse_input(user_input) when is_binary(user_input) do
    with groomed_input <-
           user_input
           |> String.downcase()
           |> String.trim(),
         true <-
           groomed_input
           |> String.to_charlist()
           |> Enum.all?(fn char -> char in 'abcdefghijklmnopqrstuvwxyz, ' end),
         recipe_names when is_list(recipe_names) <-
           groomed_input
           |> String.split(", ")
           |> Stream.map(&String.replace(&1, " ", "_"))
           |> Enum.map(&String.to_atom/1),
         true <-
           Enum.all?(recipe_names, fn recipe_name -> Map.has_key?(@recipes, recipe_name) end) do
      {:ok, recipe_names}
    else
      _ -> {:error, "Cannot parse input"}
    end
  end

  def choose_recipes([_single_recipe]), do: %{hard_conflicts: %{}, soft_conflicts: []}

  def choose_recipes(recipe_names) when is_list(recipe_names) do
    with %{soft_conflicts: _, ingredients_in_recipes: _} = unfinished_conflicts <-
           @ingredients_used_in_recipes
           |> Stream.filter(fn {_ingredient, recipes} ->
             Enum.any?(recipe_names, &Map.has_key?(recipes, &1))
           end)
           |> Stream.map(fn {ingredient, recipes} ->
             {ingredient, Map.take(recipes, recipe_names)}
           end)
           |> calculate_soft_conflicts(),
         %{soft_conflicts: _, hard_conflicts: _} = conflicts <-
           calculate_hard_conflicts(unfinished_conflicts)
           |> Map.take([:soft_conflicts, :hard_conflicts]) do
      {:ok, conflicts}
    else
      _ -> {:error, "Cannot calculate conflicts"}
    end
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
