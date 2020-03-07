defmodule VesperiaWeb.Live.OptimalRecipes do
  use Phoenix.LiveView

  alias Vesperia.Cooking.RecipeOptimizer

  def mount(_params, _session, socket) do
    {:ok, assign(socket, optimal_recipe_combos: [], requests: 0)}
  end

  def render(assigns) do
    Phoenix.View.render(VesperiaWeb.OptimalRecipesView, "index.html", assigns)
  end

  # def handle_event("find_optimal_recipes", _params, %{assigns: %{requests: requests}} = socket)
  #     when requests > 0 do
  #   IO.inspect("SUCCESSFULLY RAN INTO THE WALL")
  #   {:noreply, socket}
  # end

  def handle_event(
        "find_optimal_recipes",
        %{"form" => %{"store" => store, "visit" => visit}},
        socket
      ) do
    IO.inspect("here")
    IO.inspect(socket)

    {:ok, optimal_recipe_combos} = RecipeOptimizer.optimalize_recipes(store, visit)

    {:noreply,
     socket
     |> assign(optimal_recipe_combos: optimal_recipe_combos)
     |> update(:requests, &(&1 + 1))}
  end
end
