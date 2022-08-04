defmodule PhxapiWeb.UserController do
  use PhxapiWeb, :controller

  alias Phxapi.User

  def index(conn, %{"success" => success}) do
    success |> User.create() |> handle_response(conn)

    # |> json([
    #   %{
    #     firstname: "John",
    #     lastname: "Doe",
    #     age: 32,
    #     socials: %{github: "johndoe", twitter: "@johndoe"}
    #   }
    # ])
  end

  defp handle_response({:ok, user}, conn) do
    conn
    |> put_status(200)
    |> render("create.json", user: user)
  end

  defp handle_response({:error, message}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: message})
  end
end
