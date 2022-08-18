defmodule Phxrest.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Phxrest.Users.Role

  schema "users" do
    field :name, :string

    belongs_to :role, Role
  end

  def changeset(users, attrs) do
    users
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
