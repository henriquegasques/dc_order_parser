# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :order_payload_parser,
  ecto_repos: [OrderPayloadParser.Repo]

# Configures the endpoint
config :order_payload_parser, OrderPayloadParserWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fB/Y8bi1Q///ebH+YK/KjGzOxKXaI6e1fQP1CAqw5OEt5yxyY12ADUjVMOgFcjG9",
  render_errors: [view: OrderPayloadParserWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: OrderPayloadParser.PubSub,
  live_view: [signing_salt: "B0R8FXyD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
