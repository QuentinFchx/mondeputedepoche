# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :an,
  ecto_repos: [An.Repo]

# Configures the endpoint
config :an, An.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CjAf5mfyt+gfoou8tezIlSGjsLvEh356/goZPM6W0PDwkNp2pEeSC1r+oScf6/sK",
  render_errors: [view: An.ErrorView, accepts: ~w(html json)],
  pubsub: [name: An.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sentry,
  dsn: "https://fb79ff8316e044ae8ed5426f05e2fb70:07ac66908f4b455b83a6c67574f1a9ec@sentry.io/109076",
  included_environments: [:prod],
  environment_name: Mix.env

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
