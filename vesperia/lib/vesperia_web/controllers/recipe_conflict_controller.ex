defmodule VesperiaWeb.RecipeConflictController do
  use VesperiaWeb, :controller

  alias Vesperia.Cooking.RecipeConflictFinder

  def index(conn, _params) do
    render(conn, "index.html", recipe_conflicts: %{})
  end

  def submit(conn, %{user_input: user_input}) do
    recipe_conflicts = RecipeConflictFinder.find_conflicts(user_input)

    render(conn, "index.html", recipe_conflicts: recipe_conflicts)
  end
end
