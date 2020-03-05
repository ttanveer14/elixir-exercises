defmodule Vesperia.Cooking.StoreRecipeFinder do
  @recipes Vesperia.Info.Recipes.recipes()
  @ingredients_by_type Vesperia.Info.Ingredients.ingredient_groups()
  @ingredient_types Vesperia.Info.Ingredients.ingredient_types()

  alias Vesperia.Info.Stores

  def recipes_available(store_name, visit_number \\ 3, opts \\ []) do
    ingredients_available =
      visit_number
      |> Stores.stores()
      |> Map.fetch!(store_name)

    recipes = Enum.filter(@recipes, &can_cook?(&1, ingredients_available))

    if Enum.member?(opts, :names_only) do
      Keyword.keys(recipes)
    else
      recipes
    end
  end

  defp can_cook?({_recipe_name, ingredients_map}, ingredients_available) do
    ingredients_map
    |> Map.keys()
    |> Enum.all?(&right_ingredient?(&1, ingredients_available))
  end

  defp right_ingredient?(ingredient_group, ingredients_available)
       when ingredient_group in @ingredient_types do
    @ingredients_by_type
    |> Map.fetch!(ingredient_group)
    |> Enum.any?(fn ingredient -> Enum.member?(ingredients_available, ingredient) end)
  end

  defp right_ingredient?(ingredient, ingredients_available) do
    ingredient in ingredients_available
  end
end
