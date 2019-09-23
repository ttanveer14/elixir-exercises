defmodule VesperiaWeb.RecipeController do
  use VesperiaWeb, :controller

  @recipes Vesperia.Info.Recipes.recipes()

  def recipe(conn, %{"recipe_name" => recipe_name}) do
    recipe = Map.fetch!(@recipes, String.to_atom(recipe_name))

    render(conn, "index.html", recipe_name: recipe_name, recipe: recipe)
  end
end
