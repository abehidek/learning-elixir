defmodule Phxrest.Repo do
  use Ecto.Repo,
    otp_app: :phxrest,
    adapter: Ecto.Adapters.Postgres
end
