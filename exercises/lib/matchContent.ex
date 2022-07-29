defmodule MatchContent do
  def main() do
    x = 10
    arr = [1, 2, 3, 4, 5, x]
    [1, 2, 3, y, 5, x] = arr
    IO.inspect(y)

    fixed = "pirula"

    greet = fn
      ^fixed, name -> "Hi from pirula #{name}"
      fixed, name -> "#{fixed} #{name}"
    end

    greet.("pirula", "pitbull") |> IO.puts()
    greet.("Hello", "eba") |> IO.puts()
  end
end
