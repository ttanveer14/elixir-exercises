defmodule VesperiaWeb.RecipeConflictController do
  use VesperiaWeb, :controller

  def index(conn, _params) do
    live_render(conn, VesperiaWeb.Live.RecipeConflicts, session: %{})
  end
end
