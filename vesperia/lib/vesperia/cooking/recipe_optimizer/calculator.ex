defmodule Vesperia.Cooking.RecipeOptimizer.Calculator do
  alias Vesperia.Cooking.StoreRecipeFinder

  def generate_recipe_combos(store, visit) do
    store
    |> StoreRecipeFinder.recipes_available(visit, [:names_only])
    |> generate_combinations()
    |> Stream.uniq()
    |> Enum.sort()
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
