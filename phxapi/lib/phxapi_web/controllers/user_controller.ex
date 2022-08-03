defmodule PhxapiWeb.UserController do
  use PhxapiWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> text("First API")
  end
end
