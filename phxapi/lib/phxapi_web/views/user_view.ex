defmodule PhxapiWeb.UserView do
  use PhxapiWeb, :view

  def render("create.json", %{user: user}) do
    %{
      message: "banana",
      user: user
    }
  end
end
