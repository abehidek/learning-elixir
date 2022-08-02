defmodule ExecutablesContent.CLI do
  # to build executables in elixir, you can use escript, which produces an executable that can be run in any system with erlang installed

  def main(args \\ []) do
    # do stuff
    IO.puts("Hello escript!")
    args |> parse_args() |> response() |> IO.puts()
  end

  def parse_args(args) do
    {opts, word, _} = args |> OptionParser.parse(switches: [upcase: :boolean])

    {opts, List.to_string(word)}
  end

  defp response({opts, word}) do
    if opts[:upcase], do: String.upcase(word), else: word
  end

  # to build our app, run:
  # $ mix escript.build
  # to run you can either use ./projects --upcase hello or on windows: escript projects --upcase hello
end
