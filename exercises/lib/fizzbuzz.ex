defmodule FizzBuzz do
  def run() do
    run(1)
  end

  def run(number) when number <= 100 do
    cond do
      rem(number, 15) == 0 -> IO.puts("FizzBuzz")
      rem(number, 5) == 0 -> IO.puts("Buzz")
      rem(number, 3) == 0 -> IO.puts("Fizz")
      true -> IO.puts("Number: #{number}")
    end

    run(number + 1)
  end

  def run(_number) do
    IO.puts("End")
  end
end
