defmodule ErlangContent do
  def factorial(number) when number > 0 do
    number * factorial(number - 1)
  end

  def factorial(_number) do
    1
  end

  def timed(fun, args) do
    # Erlang modules are represented as lowercase atoms, such as :os, or :timer
    {timed, result} = :timer.tc(fun, args)
    IO.puts("Time: #{timed}")
    IO.puts("Result: #{result}")
  end

  @spec erlang_package :: :ok
  def erlang_package do
    palette = {:rgb, 8, [{255, 0, 0}, {128, 255, 128}, {64, 64, 255}, {0, 0, 0}]}
    {:ok, file} = File.open("lib/sample.png", [:write])

    :png.create(%{
      :size => {30, 30},
      :mode => {:indexed, 8},
      :file => file,
      :palette => palette,
    })

    :ok
  end
end
