# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :spawn_api,
  ecto_repos: [SpawnApi.Repo]

# Configures the endpoint
config :spawn_api, SpawnApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "q24uFl55c0qsR+A3dUTrk51f6tYCq9IpL7nKubvR5u0GtPj8Qnw7278gOf0BzEpE",
  render_errors: [view: SpawnApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SpawnApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
