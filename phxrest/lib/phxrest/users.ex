defmodule Phxrest.Users do

  import Ecto.Query, warn: false
  alias Phxrest.Repo
  alias Phxrest.Users.Role
  alias Phxrest.Users.User

  def list_roles, do: Repo.all(Role)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert!()
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!()
  end
end
