defmodule SigilContent do
  # alternative synthax for working with literals
  def sigils_functions do
    # charlist
    ~c/2+7 = #{2 + 7}/
    ~C/2 + 7 = #{2 + 7}/
    # regex
    regx = ~r/elixir/
    # to turn off case sensitivity, append i to the end of the sigil
    regx2 = ~r/elixir/i
    ("Elixir" =~ regx) |> IO.inspect()
    ("elixir" =~ regx) |> IO.inspect()
    ("Elixir" =~ regx2) |> IO.inspect()
    ("elixir" =~ regx2) |> IO.inspect()

    # string, similarly to the charlist sigil, you can use escape sequences
    ~s/2+2 probably is #{2 + 2}/
    ~S/some random phrase here/

    # word list
    ~w/elixir is pretty good dont you think #{"john"}/ |> IO.inspect()
    # ["elixir", "is", "pretty", "good", "dont", "you", "think", "john"]
    ~W/elixir is pretty good dont you think #{"john"}/ |> IO.inspect()
    # ["elixir", "is", "pretty", "good", "dont", "you", "think", "\#{\"john\"}"]

    # NaiveDateTime, useful when you want to represent DateTime without a timezone
    # For the most part, we should avoid creating a NaiveDateTime struct directly. However, it is useful for pattern matching. For example:
    (NaiveDateTime.from_iso8601("2015-01-23 23:50:07") == {:ok, ~N[2015-01-23 23:50:07]})
    |> IO.inspect()

    # DateTime, useful when you want to create a struct to represent a DateTime with a UTC timezone,

    (DateTime.from_iso8601("2015-01-23 23:50:07Z") == {:ok, ~U[2015-01-23 23:50:07Z], 0})
    |> IO.inspect()

    (DateTime.from_iso8601("2015-01-23 23:50:07-0600") == {:ok, ~U[2015-01-24 05:50:07Z], -21600})
    |> IO.inspect()

    :ok
  end

  # Creating your own sigil
  defmodule MySigils do
    def sigil_p(string, []), do: String.upcase(string)
    #iex(13)> ~p/test/
    #"TEST"
  end
end
