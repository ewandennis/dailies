# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :giflator,
  ecto_repos: [Giflator.Repo]

# Configures the endpoint
config :giflator, Giflator.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qsbcbQbwq1vPCC5ANho2SXaG2vhpTYlfQMTmy4Yc9QUvEM45b2MaMxVwUlAeWDPm",
  render_errors: [view: Giflator.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Giflator.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
