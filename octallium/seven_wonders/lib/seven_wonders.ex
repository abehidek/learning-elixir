defmodule SevenWonders do
  @moduledoc false
  defstruct name: "", country: ""

  @type t :: %SevenWonders{
          name: String.t(),
          country: String.t()
        }

  @spec all :: [t()]
  def all,
    do: [
      %SevenWonders{name: "Taj Mahal", country: "India"},
      %SevenWonders{name: "Christ the Redeemer", country: "Brazil"},
      %SevenWonders{name: "The Great Wall of China", country: "China"},
      %SevenWonders{name: "Machu Picchu", country: "Peru"},
      %SevenWonders{name: "Colosseum", country: "Italy"}
    ]

  @spec print_names(wonders :: [t()]) :: :ok
  def print_names(wonders), do: Enum.each(wonders, fn %{name: name} -> IO.puts(name) end)

  @spec print_names2(wonders :: [t()]) :: [String.t()]
  # for comprehension
  def print_names2(wonders), do: for(%{name: name} <- wonders, do: name)

  @spec filter_by_country(wonders :: [t()], String.t()) :: [t()]
  def filter_by_country(wonders, country) do
    Enum.filter(wonders, fn %{country: c} -> country == c end)
  end

  def countries_names_starting_with_i(wonders) do
    Enum.filter(wonders, fn %{country: c} -> String.starts_with?(String.downcase(c), "i") end)
  end

  def sort_by_country_legth(wonders) do
    Enum.sort_by(wonders, fn %{country: c} -> String.length(c) end)
  end

  def name_country_list(wonders) do
    Enum.map(wonders, fn w ->
      [w.name, w.country]
    end)
  end

  def name_country_list2(wonders) do
    Enum.reduce(wonders, [], fn w, acc -> [[w.name, w.country] | acc] end)
  end

  def name_country_kw_list(wonders) do
    Enum.map(wonders, fn w ->
      ["#{w.country}": w.name]
    end)
  end

  def name_country_kw_list2(wonders) do
    Enum.reduce(wonders, [], fn w, acc -> [{String.to_atom(w.name), w.country} | acc] end)
  end
end
