defmodule Phxrest.CountriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Phxrest.Countries` context.
  """

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{
        name: "some name",
        population: 42
      })
      |> Phxrest.Countries.create_country()

    country
  end
end
