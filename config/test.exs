use Mix.Config

# Configure your database
config :bb, BB.Repo,
  username: "postgres",
  password: "postgres",
  database: "bb_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bb, BBWeb.Endpoint,
  http: [port: 4002],
  server: false

config :phoenix_integration,
  endpoint: BBWeb.Endpoint

# Print only warnings and errors during test
config :logger, level: :warn

config :bcrypt_elixir, :log_rounds, 1
