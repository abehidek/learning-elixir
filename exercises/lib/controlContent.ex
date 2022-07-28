import Integer

defmodule ControlContent do
  def main() do
    m = %{a: 1, c: 3, d: 4}

    with {:ok, number} <- Map.fetch(m, :e), true <- is_even(number) do
      IO.puts("#{number} is even lmao")
      :even
    else
      :error ->
        IO.puts("We dont have this item on map")
        :error

      _ ->
        IO.puts("It is odd")
        :odd
    end
  end
end
