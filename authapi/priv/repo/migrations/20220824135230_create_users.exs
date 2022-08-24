defmodule Authapi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      add :password, :string

      timestamps()
    end
  end
end
