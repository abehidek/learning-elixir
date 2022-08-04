defmodule HelloWeb.CounterController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "counter.html")
  end
end
