defmodule Phxrest.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field :name, :string
    field :population, :integer

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name, :population])
    |> validate_required([:name, :population])
  end
end
