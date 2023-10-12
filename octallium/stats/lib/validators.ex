defmodule Stats.Validators do
  @spec validate_num_list([number()]) :: {boolean(), [number()]} | {atom(), String.t()}
  def validate_num_list(nums) when is_list(nums) do
    {Enum.all?(nums, fn e -> is_number(e) end), nums}
  end

  def validate_num_list(_), do: Stats.Errors.invalid_data_type()
end
