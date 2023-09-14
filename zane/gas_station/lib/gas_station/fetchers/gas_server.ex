defmodule GasStation.Fetchers.GasServer do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      use GenServer

      defstruct last_updated: 0, last_value: nil

      @impl true
      def init(init_arg), do: {:ok, init_arg}

      def start_link(_opts) do
        GenServer.start_link(__MODULE__, %__MODULE__{}, name: __MODULE__)
      end

      def get, do: GenServer.call(__MODULE__, :fetch)
    end
  end
end
