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
  import Integer

  def filters do
    # you can think filters the same way as a guaurd for comprehensions, or the filter function for enumarables, when a filter returns a false or nil value, it's excluded from the final lists
    # to use multiple filters, just separate then with comma
    for(x <- 1..100, is_even(x), rem(x, 3) == 0, do: x) |> IO.inspect()
    :ok
  end

  def into_function do
    # if you wanna produce other thing as a list, you can use the :into option, it accepts any structure that implements the Collectable protocol
    for({k, v} <- [one: 1, two: 2, three: 3], into: %{}, do: {k, v}) |> IO.inspect()

    # %{one: 1, three: 3, two: 2} => this happens because maps are often organized by alphabetical order

    for(c <- [72, 101, 108, 108, 111], into: "", do: <<c>>) |> IO.inspect()
    :ok
  end
end
