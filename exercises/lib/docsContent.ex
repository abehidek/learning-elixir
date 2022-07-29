defmodule DocsContent do
  @moduledoc """
  All content related to documentation in elixir
  You can access this moduledoc with the h command
  in the interative elixir shell (iex)
  """

  # inline docs (comments in code)

  @doc """
  Takes an input name and greets it

  ## Parameters

    - name: String that represents the name of the person.

  ## Examples

      iex> DocsContent.hello("Sean")
      "Hello, Sean"

      iex> DocsContent.hello("pete")
      "Hello, pete"
  """
  @spec hello(String.t()) :: String.t()
  def hello(name), do: "Hello, " <> name

end
