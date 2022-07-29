defmodule PipeContent do
  # |> pipe operator pass the result of an expression to another func as first param
  # instead of writing something like this:
  # foo(bar(baz(fuu(do_something(sum())))))
  # you can write like this:
  # sum |> do_something |> fuu |> baz |> bar |> foo

  def sum(a, b) do
    a + b
  end

  def multiply(a, b) do
    a * b
  end

  def divide(a, b), do: a / b

  def calculate_function do
    number = 20
    sum(number, 10) |> multiply(3) |> divide(7)
  end

  # good practices
  # if one of the functions has a arity > 1, use parenthesis
end
