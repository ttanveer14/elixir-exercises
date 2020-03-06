defmodule Vesperia.Cooking.RecipeOptimizer.Manager do
  use GenServer

  @me RecipeOptimizer.Manager
  @result_store RecipeOptimizer.Results

  alias Vesperia.Cooking.RecipeOptimizer.{WorkerSupervisor, Calculator}

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

  def handle_info(:report_results, current_state) do
    report_results()

    Process.send_after(self(), :erase_results, 0)

    {:noreply, current_state}
  end

  def handle_info(:erase_results, _current_state) do
    Agent.stop(@result_store)

    {:noreply, []}
  end

  def handle_cast({:optimize, store, visit}, _recipe_combos) do
    recipe_combos = Calculator.generate_recipe_combos(store, visit)

    case recipe_combos do
      [only_one_combo] ->
        Agent.start_link(fn -> only_one_combo end, name: @result_store)
        Process.send_after(self(), :report_results, 0)

      _anything_else ->
        Agent.start_link(fn -> %{} end, name: @result_store)
        Process.send_after(self(), :kickoff, 0)
    end

    {:noreply, recipe_combos}
  end

  def handle_cast({:done, last_recipe_combo}, [last_recipe_combo]) do
    Process.send_after(self(), :report_results, 0)
    {:noreply, []}
  end

  def handle_cast({:done, recipe_combo}, recipe_combos) do
    {:noreply, List.delete(recipe_combos, recipe_combo)}
  end

  def handle_cast({:result, recipes, conflicts}, recipe_combos) do
    Agent.update(@result_store, &Map.put(&1, recipes, conflicts))
    {:noreply, recipe_combos}
  end

  defp report_results() do
    Agent.get(@result_store, & &1)
    |> Calculator.calculate_optimal_combos()
    |> IO.inspect()
  end
end
