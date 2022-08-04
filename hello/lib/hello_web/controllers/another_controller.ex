defmodule HelloWeb.AnotherController do
  use HelloWeb, :controller

  def index(conn, %{"message" => message}) do
    render(conn, "another.html", message: message)
  end

  def index(conn, _) do
    render(conn, "another.html", message: "No message in url")
  end
end
