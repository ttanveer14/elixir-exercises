defmodule VesperiaWeb.RecipeView do
  use VesperiaWeb, :view

  def ingredient_name({ingredient_name, _quantity}) do
    ingredient_name
    |> Atom.to_string()
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  def quantity({_, qty}), do: qty

  def recipe_name(recipe_name) do
    recipe_name
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
