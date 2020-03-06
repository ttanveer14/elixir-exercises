defmodule Vesperia.Cooking.RecipeOptimizer.Manager do
  use GenServer

  @me RecipeOptimizer.Manager

  alias Vesperia.Cooking.RecipeOptimizer.{WorkerSupervisor, Calculator, ResultStore}

  def start_link(recipe_combos) do
    GenServer.start_link(__MODULE__, recipe_combos, name: @me)
  end

  def optimize(store, visit) do
    GenServer.cast(@me, {:optimize, store, visit})
  end

  def done(recipe_combo) do
    GenServer.cast(@me, {:done, recipe_combo})
  end

  def add_result(recipe_combo, conflicts) do
    GenServer.cast(@me, {:result, recipe_combo, conflicts})
  end

  def init(recipe_combos) do
    {:ok, recipe_combos}
  end

  def handle_info(:kickoff, recipe_combos) do
    recipe_combos
    |> Enum.each(fn recipe_combo -> WorkerSupervisor.add_worker(recipe_combo) end)

    {:noreply, recipe_combos}
  end

  def handle_info(:final_results, current_state) do
    tabulate_final_results()

    {:noreply, current_state}
  end

  def handle_cast({:optimize, store, visit}, _recipe_combos) do
    recipe_combos = Calculator.generate_recipe_combos(store, visit)

    case recipe_combos do
      [only_one_combo] ->
        ResultStore.reset_results(conflicts: only_one_combo)
        Process.send_after(self(), :final_results, 0)

      _anything_else ->
        ResultStore.reset_results(conflicts: %{})
        Process.send_after(self(), :kickoff, 0)
    end

    {:noreply, recipe_combos}
  end

  def handle_cast({:done, last_recipe_combo}, [last_recipe_combo]) do
    Process.send_after(self(), :final_results, 0)
    {:noreply, []}
  end

  def handle_cast({:done, recipe_combo}, recipe_combos) do
    {:noreply, List.delete(recipe_combos, recipe_combo)}
  end

  def handle_cast({:result, recipes, conflicts}, recipe_combos) do
    ResultStore.add_conflict(recipes, conflicts)

    {:noreply, recipe_combos}
  end

  defp tabulate_final_results() do
    optimal_combos =
      ResultStore.get_conflicts()
      |> Calculator.calculate_optimal_combos()
      |> ResultStore.add_optimal_combos()
  end
end
