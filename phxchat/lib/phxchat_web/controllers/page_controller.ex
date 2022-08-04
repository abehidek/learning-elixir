defmodule PhxchatWeb.PageController do
  use PhxchatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
