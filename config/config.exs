# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bb,
  namespace: BB,
  ecto_repos: [BB.Repo]

# Configures the endpoint
config :bb, BBWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BUBYVcvQnZFpWqyE3A/f4dU7S26nHpoZYPlwh+7BZ2/Af4aGiSDNCVe0LiG2h4Ds",
  render_errors: [view: BBWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: BB.PubSub,
  live_view: [signing_salt: "fjFxj2pW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
