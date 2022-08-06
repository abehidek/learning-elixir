defmodule PhxapidbWeb.HomeController do
  use PhxapidbWeb, :controller

  def index(conn, _params) do
    conn |> json(%{hello: "World!"})
  end
end
