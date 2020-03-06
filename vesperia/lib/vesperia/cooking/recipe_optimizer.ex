defmodule Vesperia.Cooking.RecipeOptimizer do
  alias Vesperia.Cooking.RecipeOptimizer.{ResultStore, Manager}

  def find_optimal_recipes(store, visit) do
    {:ok, _pid} = ResultStore.start_link(:no_args)

    Manager.optimize(store, visit)

    optimal_combos = get_results()

    ResultStore.stop()

    optimal_combos
  end

  defp get_results() do
    get_results([])
  end

  defp get_results([]) do
    ResultStore.get_optimal_combos()
    |> get_results()
  end

  defp get_results(results), do: results
end
