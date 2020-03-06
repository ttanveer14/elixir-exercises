defmodule Vesperia.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Vesperia.Repo, []),
      # Start the endpoint when the application starts
      supervisor(VesperiaWeb.Endpoint, []),
      supervisor(Vesperia.Cooking.RecipeOptimizer.WorkerSupervisor, []),
      # Start your own worker by calling: Vesperia.Worker.start_link(arg1, arg2, arg3)
      {Vesperia.Cooking.RecipeOptimizer.ResultStore, []},
      {Vesperia.Cooking.RecipeOptimizer.Manager, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vesperia.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VesperiaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
