defmodule Vesperia.Cooking.RecipeOptimizer.ResultStore do
  use Agent

  @me RecipeOptimizer.ResultStore

  alias Vesperia.Cooking.RecipeOptimizer.Results

  def start_link(_args) do
    Agent.start_link(fn -> %Results{} end, name: @me)
  end

  def reset_results(opts \\ []) do
    Agent.update(@me, fn _results -> %Results{conflicts: opts[:conflicts]} end)
  end

  def stop() do
    Agent.stop(@me, :normal)
  end

  def add_conflict(recipe_combo, conflicts) do
    Agent.update(
      @me,
      &Map.update!(&1, :conflicts, fn conflict_map ->
        Map.put(conflict_map, recipe_combo, conflicts)
      end)
    )
  end

  def add_optimal_combos(optimal_combos) do
    Agent.update(@me, &Map.replace!(&1, :optimal_combos, optimal_combos))
  end

  def get_conflicts() do
    Agent.get(@me, &Map.fetch!(&1, :conflicts))
  end

  def get_optimal_combos() do
    Agent.get(@me, &Map.fetch!(&1, :optimal_combos))
  end
end
