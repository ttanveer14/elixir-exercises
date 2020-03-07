defmodule VesperiaWeb.OptimalRecipesController do
  use VesperiaWeb, :controller

  def index(conn, _params) do
    live_render(conn, VesperiaWeb.Live.OptimalRecipes, session: %{})
  end
end
