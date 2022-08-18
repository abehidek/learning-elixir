defmodule Phxrest.Users.Role do
  use Ecto.Schema
  alias Phxrest.Users.User

  schema "roles" do
    field :name, :string

    has_many :users, User
  end
end
