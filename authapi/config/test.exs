import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :authapi, Authapi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "authapi_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :authapi, AuthapiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "QBY2TNVwTf9cxoRebDoj4TespE7pWR0dM+k571zphWvEO3fhJ28EdG/vzQN0bftQ",
  server: false

# In test we don't send emails.
config :authapi, Authapi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
