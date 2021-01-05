# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dummy,
  ecto_repos: [Dummy.Repo]

# Configures the endpoint
config :dummy, DummyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ddPqrlhfk9HdQg5RayAMEqafmKSGuHzBBhyx3PQBiQK0XRSgu0GKjHk67SFTRx+E",
  render_errors: [view: DummyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dummy.PubSub,
  live_view: [signing_salt: "P0sj3qDS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
