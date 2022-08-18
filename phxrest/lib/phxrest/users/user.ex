defmodule Phxrest.Users.User do
  use Ecto.Schema
  alias Phxrest.Users.Role

  schema "users" do
    field :name, :string

    belongs_to :role, Role
  end
end
