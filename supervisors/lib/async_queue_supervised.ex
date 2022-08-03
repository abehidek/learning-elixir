defmodule AsyncQueueSupervised do
  @moduledoc false
  use GenServer

  def init(state), do: {:ok, state}

  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  def handle_cast({:dequeue}, [_value | state]) do
    {:noreply, state}
  end

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.cast(__MODULE__, {:dequeue})
end
