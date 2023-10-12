defmodule Stats.CentralTendency.Mode do
  @moduledoc false

  def mode(nums) when is_list(nums) do
    ranked_map = nums |> Enum.frequencies()

    ranked_map
    |> Map.values()
    |> Enum.max()
    |> mode_func(ranked_map)
  end

  defp mode_func(1, _ranked_map), do: nil

  defp mode_func(max, ranked_map) do
    ranked_map
    |> Map.filter(fn {_k, v} -> v == max end)
    |> Map.keys()
  end
end
