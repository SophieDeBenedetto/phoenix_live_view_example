# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pair,
  ecto_repos: [Pair.Repo]

# Configures the endpoint
config :pair, PairWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OTd8G6pUrDJlBnenUHT5d1c14aFRm2/ixeX1X8Nb80FaM+6Jkcxd8YjxzrTWv6nG",
  render_errors: [view: PairWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pair.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "DUEJzFYf1EotxOVzHCXv2f8X0if5l0ik"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


config :phoenix,
 template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
