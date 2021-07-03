# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :salt_houses,
  ecto_repos: [SaltHouses.Repo]

# Configures the endpoint
config :salt_houses, SaltHousesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yKe9nkgYQWC2jM0o9XgpLBHjlUr+iTa8nxvrSqANj5T09DWt8s2d9thhHAj3Zwxb",
  render_errors: [view: SaltHousesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SaltHouses.PubSub,
  live_view: [signing_salt: "fk9ih1+i"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
