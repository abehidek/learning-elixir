defmodule Authapi.Repo do
  use Ecto.Repo,
    otp_app: :authapi,
    adapter: Ecto.Adapters.Postgres
end
