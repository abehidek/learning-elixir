defmodule FunctionsContent do
  def length_of([]), do: 0
  def length_of([_ | tail]), do: 1 + length_of(tail)

  def hello(%{name: person_name}) do
    IO.puts("Hello, #{person_name}")
  end
end
