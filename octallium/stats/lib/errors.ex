defmodule Stats.Errors do
  @spec invalid_data_type() :: {atom(), String.t()}
  def invalid_data_type(), do: {:error, "Invalid data type"}
end
