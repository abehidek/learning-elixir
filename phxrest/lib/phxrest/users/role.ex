defmodule Phxrest.Users.Role do
  use Ecto.Schema
  import Ecto.Changeset
  alias Phxrest.Users.User

  schema "roles" do
    field :name, :string

    has_many :users, User
  end

  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
