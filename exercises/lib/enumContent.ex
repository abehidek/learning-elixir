defmodule Adding do
  def plus_three(number), do: number + 3
end

defmodule EnumContent do
  def get_all_functions do
    Enum.__info__(:functions)
    |> Enum.each(fn {function, arity} ->
      IO.puts("#{function} #{arity}")
    end)
  end

  def main_functions do
    arr = [4, 10, 9, 20, 8]
    foo = [1, 2, 3, 4, 5, 6, 7]

    Enum.filter(arr, fn x -> x > 5 end) |> IO.inspect()
    Enum.reduce(foo, fn x, acc -> x + acc end) |> IO.inspect()
    Enum.map(arr, &(&1 + 3)) |> IO.inspect()

    anom_func = &(&1 / &2)
    anom_func.(1, 2) |> IO.inspect()

    # using anom func
    Enum.map(arr, fn number -> Adding.plus_three(number) end) |> IO.inspect()
    # using catch operator
    Enum.map(arr, &Adding.plus_three(&1)) |> IO.inspect()
  end
end
