defmodule SimpleQueueSupervised do
  @moduledoc false
  use GenServer

  def child_spec(opts) do
    %{
      # required key. Used by the sup to identify the child specification
      id: SimpleQueueSupervised,
      # required key Module/Function/Arguments to call when started by sup
      start: {__MODULE__, :start_link, [opts]},
      # Optional. Defines child behavior during shutdown
      # Options are:
      # :brutal_kill => Child is stopped imediatelly
      # 0 or positive int => time in miliseconds supervisor will wait before killing process, if the process is :worker type, shutdown defaults to 5000.
      # :infinity => Supervisor will wait indefinitely before killing child process. Default for :supervisor process type. Not recomended to :worker type.
      shutdown: 5_000,
      # Optional, handles process crash
      # there are several approaches for handling child process crashes:
      # :permanent => Child always restart. Default for all processes
      # :temporary => Child process is never restarted
      # :transient => Child process is restarted only if terminates abnormally
      restart: :permanent,
      # Optional, process can either be :worker or :supervisor. Defaults to :worker
      type: :worker
    }
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state), do: {:ok, state}

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def queue, do: GenServer.call(__MODULE__, :queue)
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
