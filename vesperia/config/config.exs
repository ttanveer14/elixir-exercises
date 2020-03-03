# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vesperia,
  ecto_repos: [Vesperia.Repo]

# Configures the endpoint
config :vesperia, VesperiaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1v15zMEUKvbq4Py5p1KCHgjYemkjpdwambIuFy26kNYeH1iVphSvsyU/5QS98tMg",
  render_errors: [view: VesperiaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Vesperia.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "fNODAr4Ji+T+91D14p6hVnQT4H1DZijG"
  ],
  json_library: Poison

config :vesperia, Repo,
  database: "vesperia_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
