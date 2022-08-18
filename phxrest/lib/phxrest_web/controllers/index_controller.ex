defmodule PhxrestWeb.IndexController do
  use PhxrestWeb, :controller

  def index(conn, _params) do
    conn |> json(%{hello: "World"})
  end
end
