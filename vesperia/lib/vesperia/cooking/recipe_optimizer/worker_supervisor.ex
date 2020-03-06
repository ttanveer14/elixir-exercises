defmodule Vesperia.Cooking.RecipeOptimizer.WorkerSupervisor do
  use DynamicSupervisor

  @me RecipeOptimizer.WorkerSupervisor

  alias Vesperia.Cooking.RecipeOptimizer.Worker

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_worker(recipes) do
    {:ok, _pid} = DynamicSupervisor.start_child(@me, {Worker, recipes})
  end
end
