defmodule Phxrest.CountriesTest do
  use Phxrest.DataCase

  alias Phxrest.Countries

  describe "countries" do
    alias Phxrest.Countries.Country

    import Phxrest.CountriesFixtures

    @invalid_attrs %{name: nil, population: nil}

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Countries.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Countries.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      valid_attrs = %{name: "some name", population: 42}

      assert {:ok, %Country{} = country} = Countries.create_country(valid_attrs)
      assert country.name == "some name"
      assert country.population == 42
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Countries.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      update_attrs = %{name: "some updated name", population: 43}

      assert {:ok, %Country{} = country} = Countries.update_country(country, update_attrs)
      assert country.name == "some updated name"
      assert country.population == 43
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Countries.update_country(country, @invalid_attrs)
      assert country == Countries.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Countries.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Countries.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Countries.change_country(country)
    end
  end
end
