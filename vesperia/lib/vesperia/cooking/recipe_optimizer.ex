defmodule Vesperia.Cooking.RecipeOptimizer do
  alias Vesperia.Cooking.RecipeOptimizer.{ResultStore, Manager, Lens}

  def optimalize_recipes(store_input, visit_input) do
    with {:ok, store, visit} <- Lens.sanitize_input(store_input, visit_input),
         {:ok, _pid} <- ResultStore.start_link(:no_args),
         :ok <- Manager.optimize(store, visit),
         optimal_combos <- get_results(),
         :ok <- ResultStore.stop(),
         pretty_optimal_combos <- Lens.sanitize_output(optimal_combos) do
      {:ok, pretty_optimal_combos}
    else
      e -> e
    end
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
