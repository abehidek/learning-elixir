defmodule FacPowErr do
  @moduledoc """
  Documentation for `FacPowErr`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FacPowErr.hello()
      :world

  """
  def hello do
    :world
  end

  def factorial(num, acc \\ 1)
  def factorial(1, acc), do: acc

  def factorial(num, acc) when is_integer(num) and num > 1 do
    factorial(num - 1, acc * num)
  end

  def pow(num) when is_integer(num), do: num ** 2
end
