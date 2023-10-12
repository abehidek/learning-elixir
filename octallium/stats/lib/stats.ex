defmodule Stats do
  @moduledoc false

  alias Stats.CentralTendency.{Mean, Median, Mode}
  def population_mean(nums), do: Mean.population_mean(nums)
  defdelegate sample_mean(nums), to: Mean

  defdelegate median(nums), to: Median

  defdelegate mode(nums), to: Mode
end
