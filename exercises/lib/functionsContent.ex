defmodule FunctionsContent do
  # functions essentialy are defined/identified by their name and arity (number of args), like hello/1
  def length_of([]), do: 0
  def length_of([_ | tail]), do: 1 + length_of(tail)

  # this method receives an map and match their key-value pairs, if key name matches, receives their value, in this case the person_name
  def hello(%{name: person_name}) do
    IO.puts("Hello, #{person_name}")
  end

  # this however, does the pattern matching and then gets the entire map
  def hello2(%{name: person_name} = person) do
    IO.puts("Hello, " <> person_name)
    IO.inspect(person)
  end

  # which is the same as:
  def hello3(person = %{name: person_name}) do
    IO.puts("Hello, " <> person_name)
    IO.inspect(person)
  end

  # pattern matching w/ functions:

  def pattern_matching do
    handle_result = fn
      {:ok, result} -> IO.puts("Handling result #{result}")
      {:ok, _} -> IO.puts("This would be never run as previous will be matched beforehand.")
      {:error} -> IO.puts("An error has ocurred")
    end

    some_result = 1

    handle_result.({:ok, some_result}) |> IO.inspect()
    handle_result.({:error}) |> IO.inspect()
  end

  # private functions be like:
  defp private_function do
    IO.puts("Private function...")
  end

  def public_function do
    private_function()
  end

  # guards functions:
  def guard_function(names) when is_list(names) do
    names = Enum.join(names, ", ")
    guard_function(names)
  end

  def guard_function(names) when is_binary(names) do
    "Hello " <> names
  end

  # default values for args in functions
  defp phrase("en"), do: "Hello, "
  defp phrase("pt"), do: "Olá, "

  def default_args_function(name, lang \\ "en") do
    phrase(lang) <> name
  end

  # combining guards w/ default values however has a observation:
  # def combining_function(names, lang \\ "en") when is_list(names) do
  #   names = Enum.join(names, ", ")
  #   combining_function(names, lang)
  # end
  # this error happens because elixir allows defaults to be declared once per definition.
  # def combining_function(names, lang \\ "en") when is_binary(names) do
  #   phrase(lang) <> names
  # end
  # so the solution is to write like:

  def correct_combining_function(names, lang \\ "en")

  def correct_combining_function(names, lang) when is_list(names) do
    names = Enum.join(names, ", ")
    correct_combining_function(names, lang)
  end

  def correct_combining_function(names, lang) when is_binary(names) do
    phrase(lang) <> names
  end
end
