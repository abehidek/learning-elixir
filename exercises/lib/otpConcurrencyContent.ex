# OTP Concurrency
# Elixir's abstraction for concurrency are great however sometimes we need greater control, and for that we turn to the OTP behaviors that elixir is built on
# This lesson focus on the biggest piece: GenServers

# An OTP Server is a module with the GenServer behavior that implements a set of callbacks. At its most basic level, a GenServer is a single process which runs a loop that handles one message per iteration passing along an updated state.

# To demonstrate the GenServer API we will implement a basic queue to store and retrieve values. To begin our GenServer we need to start it and handle initialization. In most cases we will want to link processes so we can use "GenServer.start_link/3".

# We pass in the GenServer module we're starting, initial arguments, and a set of GenServer options. The arguments will be passed to "GenServer.init/1" which sets the initial state through its return value. In our example the arguments will be our initial state.

defmodule SimpleQueue do
  use GenServer

  @doc """
  Start our queue and link it.
  This is a helper function
  """

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc """
  GenServer.init/1 callback
  """
  def init(state), do: {:ok, state}

  # Synchronous Functions
  # It's often necessary to interact with GenServers in a synchronous way, calling a function and waiting for its response. To handle synchronous requests we need to implement the GenServer.handle_call/3 callback which tkaes the request, the caller's PID, and the existing state; it is expected to reply by returning a tuple {:reply, response, state}

  # With pattern matching we can define callbacks for many different requests and state. A complete list of accepted values can be found in the GenServer.handle_call/3 docs.

  # To demonstrate synchronous requests lets add the ability to display our current queue and to remove a value

  @doc """
  GenServer.handle_call/3 callback
  """
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def queue, do: GenServer.call(__MODULE__, :queue)
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end

# Async requests are handled with the handle_cast/2 callback, which works pretty much the same as handle_call/3, but does not receive the caller and is not expected to reply
defmodule AsyncQueue do
  use GenServer

  @doc """
  GenServer.init/1 callback
  """
  def init(state), do: {:ok, state}

  @doc """
  GenServer.handle_cast/2 callback
  """
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  def handle_cast({:dequeue}, [_value | state]) do
    {:noreply, state}
  end

  # how to use handle_cast w/ :replying?
  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.cast(__MODULE__, {:dequeue})
end
