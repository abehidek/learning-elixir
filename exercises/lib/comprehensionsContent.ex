defmodule ComprehensionsContent do
  @moduledoc """
    # List comprehensions are syntactic sugar for looping through enumerables in Elixir.
  """

  @doc """
  Basics
  """
  def basics do
    # Comprehensions can often be used to produce more concise statements for Enum and Stream iteration
    list = [1, 2, 3, 5, 10, 4, 7]
    for(x <- list, do: x * x) |> IO.inspect()

    # Comprehensions arent limited by lists, any enumerable can be used
    # keyword lists:
    for({_key, val} <- [one: 1, two: 2, three: 3], do: val + 2) |> IO.inspect()

    # maps:
    for({k, v} <- %{"a" => "A", "b" => "B", "c" => "C"}, do: "key: #{k}, value: #{v}")
    |> IO.inspect()

    # binaries:
    for(<<c <- "hello">>, do: <<c>>) |> IO.inspect()

    # like many other things in elixir, generator rely on pattern matching to compare their input set to the left side variable, in the match the value is not found, its simply ignored

    for({:ok, val} <- [ok: "Hello", error: "Unknown", ok: "World"], do: val) |> IO.inspect()
    # ["Hello", "World"]

    # its possible to use multiple generators, like nested loops
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    for n <- arr, times <- 1..n do
      String.duplicate("*", times)
    end
    |> IO.inspect()

    :ok
  end

  @doc """
  Filters
  """
  def filters do
  end
end
