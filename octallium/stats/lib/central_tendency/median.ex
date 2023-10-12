defmodule Stats.CentralTendency.Median do
  require Integer
  # Median -> Central value or the value which divides measurements in two equal parts

  def median(nums) when is_list(nums) do
    nums
    |> Stats.Validators.validate_num_list()
    |> calc_median()
  end

  def median(_), do: Stats.Errors.invalid_data_type()

  defp calc_median({:error, _msg}), do: Stats.Errors.invalid_data_type()
  defp calc_median({false, _}), do: Stats.Errors.invalid_data_type()

  defp calc_median({true, nums}) do
    count = nums |> Enum.count()

    nums
    |> Enum.sort()
    |> get_median(Integer.is_even(count), count)
  end

  defp get_median(nums, true, count) do
    a = Enum.at(nums, div(count - 1, 2))
    b = Enum.at(nums, div(count, 2))

    (a + b) / 2
  end

  defp get_median(nums, false, count), do: Enum.at(nums, div(count, 2))
end
