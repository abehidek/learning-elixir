defmodule StringsContent do
  @moduledoc """
  Elixir strings are nothing but a sequence of bytes
  """

  def sequence_of_bytes, do: <<104, 101, 108, 108, 111>>
  # prints "hello"
  # iex> sequence_of_bytes() <> <<0>>
  # prints <<104, 101, 108, 108, 111>>
  # concat with the byte 0, IEx displays the string as a binary since its not a valid string anymore
  # <<>> synthax show to the compiler that the elements inside are bytes

  @doc """
  Internally, elixir strings are represented as a sequence of bytes rather than a array of chars, however, Elixir also has a char list type (Character list).
  
  Elixir strings are enclosed with double quotes, charlist uses single quotes
  The main difference is that each value in Charlist is the unicode code point of a char, whereas in binary, the codepoints are encoded as UTF-8
  
  However, when programming with Elixir, we usually use strings, not charlists, charlist support in manly due to special Erlang modules
  """
  def charlists do
    [104, 101, 322, 322, 111] |> IO.puts()
    # he┼é┼éo
    # you can get a char unicode using ?
    # iex> ?Z => 90

    :ok
  end

  @doc """
  Codepoints are just simple unicode chars which are represented by one or more bytes, depending on the UTF-8 encoding. Chars outside of the US ASCII set, always will encode as more than one byte, for example latin chars such as à, ã, é etc that are encoded as two bytes, chars from asian langs are often encoded in 4 bytes, grapehemes consists of multiple codepoints that are rendered as a single character.
  
  The String module provides two functions to obtain them graphemes/1 and codepoints/1.
  """
  def graphemes_codepoints do
    string = "\u0061\u0301"
    string |> IO.puts()
    String.codepoints(string) |> IO.inspect()
    String.graphemes(string) |> IO.inspect()

    :ok
  end

  @doc """
  The most important functions in Elixir
  
  You can see all functions on the Strings docs
  """
  def string_functions do
    # length
    # replace
    # duplicate
    String.duplicate("Oh my", 3) |> IO.inspect()
    # split (returns a list of strings separated by pattern)
    :ok
  end

  def string_exercise_solution do
    first_word = IO.gets("Type your first word: ") |> String.replace("\n", "")
    second_word = IO.gets("Type your second word: ") |> String.replace("\n", "")

    String.reverse(first_word) |> IO.inspect()
    # interestingly, when using IO.gets, it also gets the line break, so we need to remove it!

    result =
      cond do
        String.reverse(first_word) == second_word -> "The given strings match!"
        String.reverse(first_word) != second_word -> "The strings dont match!"
        true -> "An error occurred"
      end

    {:ok, result}
  end

  defmodule AnagramSecondSolution do
    def anagram?(a, b) when is_binary(a) and is_binary(b) do
      sort_string(a) == sort_string(b)
    end

    def sort_string(string) do
      string |> String.downcase() |> String.graphemes() |> Enum.sort()
    end
  end
end
