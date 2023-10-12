defmodule Stats.CentralTendency.Mode do
  @moduledoc false

  @spec mode([number()]) :: [number()] | {atom(), String.t()}
  def mode([]), do: Stats.Errors.invalid_data_type()

  def mode(nums) when is_list(nums) do
    case Stats.Validators.validate_num_list(nums) do
      {true, _} ->
        ranked_map = nums |> Enum.frequencies()

        ranked_map
        |> Map.values()
        |> Enum.max()
        |> mode_func(ranked_map)

      {false, _} ->
        IO.inspect(nums, label: "ERROR - Invalid data type of list")
        Stats.Errors.invalid_data_type()
    end
  end

  def mode(_), do: Stats.Errors.invalid_data_type()

  @spec mode_func(number(), %{number() => number()}) :: [number()]
  defp mode_func(1, _ranked_map), do: nil

  defp mode_func(max, ranked_map) do
    ranked_map
    |> Map.filter(fn {_k, v} -> v == max end)
    |> Map.keys()
  end
end
