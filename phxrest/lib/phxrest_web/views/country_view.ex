defmodule PhxrestWeb.CountryView do
  use PhxrestWeb, :view
  alias PhxrestWeb.CountryView

  def render("index.json", %{countries: countries}) do
    %{data: render_many(countries, CountryView, "country.json")}
  end

  def render("show.json", %{country: country}) do
    %{data: render_one(country, CountryView, "country.json")}
  end

  def render("country.json", %{country: country}) do
    %{
      id: country.id,
      name: country.name,
      population: country.population
    }
  end
end
