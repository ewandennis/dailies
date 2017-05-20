use Mix.Config

config :dailies, Dailies.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "localhost"],
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

import_config "prod.secret.exs"
