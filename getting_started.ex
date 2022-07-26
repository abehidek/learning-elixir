IO.puts("Hello World")

sumTwoValues = fn a, b -> a + b end

IO.puts(sumTwoValues.(1, 3))

:atom

variable =
  case {4, 3, 2, 1} do
    {1, 2, _, 4} ->
      "nice"

    {2, 2, 2, 2} ->
      "nooo"

    _ ->
      "sad"
  end

IO.puts(variable)
