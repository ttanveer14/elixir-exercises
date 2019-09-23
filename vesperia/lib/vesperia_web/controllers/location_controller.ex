defmodule VesperiaWeb.LocationController do
  use VesperiaWeb, :controller

  alias Vesperia.Cooking.StoreRecipeFinder

  def location(conn, %{"location_name" => location_name}) do
    recipes_available =
      location_name
      |> String.to_atom()
      |> StoreRecipeFinder.recipes_available()

    render(conn, "index.html", location_name: location_name, recipes_available: recipes_available)
  end
end
