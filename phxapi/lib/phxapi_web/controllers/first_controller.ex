defmodule PhxapiWeb.FirstController do
  use PhxapiWeb, :controller

  def index(conn, _params) do
    conn
    # you can use :ok or :bad_request as well
    # the controller just takes the conn, edit and then send it to client
    # |> IO.inspect(label: "received connection")
    |> put_status(200)
    |> put_resp_header("test_header", "Hello World!")
    |> text("First API response")

    # |> IO.inspect(label: "edited connection")
  end
end
