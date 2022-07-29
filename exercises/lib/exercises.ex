defmodule Exercises do
  @moduledoc """
  Documentation for `Projects`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Projects.hello()
      :world

  """
  def hello do
    :world
  end

  def sum(a, b) do
    IO.puts("A: #{a}, B: #{b}")
    a + b
  end

  def multiply(a, b) do
    a * b
  end

  def pipe do
    foo = 15
    bar = foo |> sum(5) |> multiply(30)

    IO.puts("Result: #{bar}")
  end
end
