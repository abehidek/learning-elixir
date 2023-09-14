defmodule GasStation.Fetchers.Polygon do
  @moduledoc false
  use GasStation.Fetchers.GasServer

  @impl true
  def handle_call(:fetch, _from, %__MODULE__{} = state) do
    now = :os.system_time(:millisecond)

    if now - 30_000 > state.last_updated do
      case GasStation.Api.Polygon.fetch_response() do
        {:ok, response} ->
          IO.puts("New response: #{inspect(response)}")

          new_state = %__MODULE__{last_updated: now, last_value: response}
          {:reply, {:ok, new_state}, new_state}

        {:error, e} ->
          IO.puts("Error fetching new response. Using old value : #{inspect(e)}")

          {:reply, {:ok, state}, state}
      end
    else
      {:reply, {:ok, state}, state}
    end
  end
end
