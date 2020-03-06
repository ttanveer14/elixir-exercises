defmodule Vesperia.Cooking.RecipeOptimizer.Worker do
  use GenServer, restart: :transient

  alias Vesperia.Cooking.RecipeConflictFinder
  alias Vesperia.Cooking.RecipeOptimizer.Manager

  def start_link(recipes) do
    GenServer.start_link(__MODULE__, recipes)
  end

  def init(recipes) do
    Process.send_after(self(), {:find_conflicts, recipes}, 0)

    {:ok, nil}
  end

  def handle_info({:find_conflicts, recipes}, _) do
    {:ok, conflicts} = RecipeConflictFinder.choose_recipes(recipes)

    Manager.add_result(recipes, conflicts)

    Manager.done(recipes)

    {:stop, :normal, nil}
  end
end
