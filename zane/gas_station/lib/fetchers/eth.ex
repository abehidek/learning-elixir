defmodule Fetchers.Eth do
  @moduledoc false
  use GenServer

  defstruct last_updated: 0, last_value: nil

  @impl true
  def init(init_arg), do: {:ok, init_arg}

  @impl true
  def handle_call(:fetch, _from, %__MODULE__{} = state) do
    now = :os.system_time(:millisecond)

    if now - 30_000 > state.last_updated do
      case Api.Eth.fetch_response() do
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

  def start_link(_opts) do
    GenServer.start_link(
      __MODULE__,
      %__MODULE__{},
      name: __MODULE__
    )
  end

  def get, do: GenServer.call(__MODULE__, :fetch)
end
