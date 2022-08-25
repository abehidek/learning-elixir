defmodule AuthapiWeb.AuthController do
  use AuthapiWeb, :controller

  alias Authapi.Accounts
  alias Authapi.Accounts.User

  action_fallback AuthapiWeb.FallbackController

  def auth(conn, _params) do
    # users = Accounts.list_users()
    # render(conn, "index.json", users: users)
    conn |> json(%{hello: "world"})
  end
end
