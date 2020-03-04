defmodule VesperiaWeb.Live.Test do
  use Phoenix.LiveView

  alias Vesperia.Cooking.RecipeConflictFinder

  def render(assigns) do
    Phoenix.View.render(VesperiaWeb.RecipeConflictView, "live.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :recipe_conflicts, %{soft_conflicts: [], hard_conflicts: %{}})}
  end

  def handle_event("calculate_conflicts", %{"query" => query}, socket) do
    {:ok, recipe_conflicts} = RecipeConflictFinder.find_conflicts(query)

    {:noreply, assign(socket, :recipe_conflicts, recipe_conflicts)}
  end
end
