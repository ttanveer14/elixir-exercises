defmodule VesperiaWeb.Live.OptimalRecipes do
  use Phoenix.LiveView

  alias Vesperia.Cooking.RecipeOptimizer

  def mount(_params, _session, socket) do
    {:ok, assign(socket, optimal_recipe_combos: [])}
  end

  def render(assigns) do
    VesperiaWeb.OptimalRecipesView.render("index.html", assigns)
  end

  def handle_event(
        "find_optimal_recipes",
        %{"form" => %{"store" => store, "visit" => visit}},
        socket
      ) do
    {:ok, optimal_recipe_combos} = RecipeOptimizer.optimalize_recipes(store, visit)

    {:noreply, assign(socket, optimal_recipe_combos: optimal_recipe_combos)}
  end
end
