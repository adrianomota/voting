# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :voting,
  ecto_repos: [Voting.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :voting, VotingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wRbNFSwYQG9lHcyvcALyaxY7IP49OBTagRNnGUfvaUHmZZIRKxNqxjYVvK0zj2e3",
  render_errors: [view: VotingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Voting.PubSub,
  live_view: [signing_salt: "XdbbEg7E"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian
config :voting, VotingWeb.Guardian,
  issuer: "voting_web",
  secret_key: "vOhQIYgUKLctXCiQUZ1pSl6thgXN/B+XhGBHDtfR7Aq7QwOdFJDkhYIdtjgS4c1F"

config :voting, VotingWeb.AuthAccessPipeline,
  module: VotingWeb.Guardian,
  error_handler: VotingWeb.AuthErrorHandler

# AWS
config :voting, uploads_bucket: "", file_module: File

config :ex_aws,
  region: "us-east-1",
  json_codec: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
