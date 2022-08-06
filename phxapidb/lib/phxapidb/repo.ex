defmodule Phxapidb.Repo do
  use Ecto.Repo,
    otp_app: :phxapidb,
    adapter: Ecto.Adapters.Postgres
end
