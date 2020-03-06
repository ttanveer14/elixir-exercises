defmodule Vesperia.Cooking.RecipeOptimizer.Calculator do
  alias Vesperia.Cooking.StoreRecipeFinder

  def generate_recipe_combos(store, visit) do
    store
    |> StoreRecipeFinder.recipes_available(visit, [:names_only])
    |> generate_combinations()
    |> Stream.uniq()
    |> Enum.sort()
  end

  def calculate_optimal_combos(results) when is_list(results) do
    results
  end

  def calculate_optimal_combos(results) when is_map(results) do
    results
    |> Enum.group_by(fn {_recipe_combo, conflicts} -> quantify_hard_conflicts(conflicts) end)
    |> Enum.sort_by(fn {key, _value} -> key end, &<=/2)
    |> Stream.map(fn {_key, results} ->
      Enum.sort_by(
        results,
        fn {_recipe_combo, conflicts} -> quantify_soft_conflicts(conflicts) end,
        &<=/2
      )
    end)
    |> Enum.take(5)
    |> List.flatten()
    |> Enum.take(5)
  end

  defp quantify_hard_conflicts(conflicts) do
    conflicts
    |> Map.get(:hard_conflicts)
    |> Stream.map(fn {_ingredient, recipe_map} ->
      count_ingredient_conflicts(recipe_map)
    end)
    |> Enum.sum()
  end

  defp quantify_soft_conflicts(conflicts) do
    conflicts
    |> Map.get(:soft_conflicts)
    |> Enum.map(fn conflict_map ->
      conflict_map
      |> Enum.map(fn {_ingredient, recipe_map} -> count_ingredient_conflicts(recipe_map) end)
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  defp count_ingredient_conflicts(recipe_map) do
    recipe_map |> Map.values() |> Enum.sum()
  end

  defp generate_combinations(recipes) when length(recipes) < 5 do
    [recipes]
  end

  defp generate_combinations(recipes) do
    for w <- recipes,
        x <- recipes,
        y <- recipes,
        z <- recipes,
        Enum.uniq([w, x, y, z]) === [w, x, y, z],
        do: Enum.sort([w, x, y, z])
  end
end
