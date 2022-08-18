defmodule Phxrest.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string
      add :population, :integer

      timestamps()
    end
  end
end
