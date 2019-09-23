defmodule VesperiaWeb.LocationView do
  use VesperiaWeb, :view

  def location_name(location_name) do
    location_name
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  def recipe_name({recipe_name, _}) do
    recipe_name
    |> Atom.to_string()
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
