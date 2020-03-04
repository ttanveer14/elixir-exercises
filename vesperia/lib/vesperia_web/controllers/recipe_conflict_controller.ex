defmodule VesperiaWeb.RecipeConflictController do
  use VesperiaWeb, :controller

  alias Vesperia.Cooking.RecipeConflictFinder

  def index(conn, _params) do
    live_render(conn, VesperiaWeb.Live.RecipeConflicts, session: %{})
  end
end
