defmodule ConcurrencyContent do
  # one of the selling points for elixir is the concurrency, thanks to erlang VM.
  # concurrency on elixir is based on actors, a contained process that comunicates with another throught message passing.

  # Processes
  # processes in erlang vm are lightweight and run accross all CPUs. While it seems like native threads, they are simpler and it's not uncommon to have thousand of concurrent process in a Elixir application
  # the easiest way to create a process is through "spawn", which take either an anon or named function, when we create a new process, it returns a PID (Process Identifier) to uniquely identify it within our application.

  defmodule Process do
    def add(a, b) do
      IO.puts(a + b)
    end
  end

  # iex> spawn(ConcurrencyContent.Process, :add, [2, 5]) => 5 #PID<0.80.0>

  # Message Passing
  # to comunicate, process rely on message passing. There are two main components to this: send/2 and receive.
  # The send/2 function allow us to send messages to PIDs. To listen we use receive to match messages, if no match is found the execution continues uninterrupted.

  defmodule MessagePassing do
    def listen do
      receive do
        {:ok, "hello"} -> IO.puts("World!")
      end

      # recursion to allow us to handle multiple messages
      listen()
      # iex> pid = spawn(ConcurrencyContent.MessagePassing, :listen, [])
      # #PID<0.449.0>

      # iex> send pid, {:ok, "hello"}
      # World!
      # {:ok, "hello"}
      # iex> send pid, :ok
      # :ok
    end
  end
end

# Process Linking
# one problem with "spawn" is knowing when a process crashes. For that we need to link our processes using spawn_link. Two linked processes will receive exit notifications from each another:
defmodule Linking do
  def explode, do: exit(:kaboom)

  # iex> spawn_link(ConcurrencyContent.Linking, :explode, [])
  # ** (EXIT from #PID<0.339.0>) shell process exited with reason: :kaboom
  # sometimes we dont want our linked process to crash the current one. For that we need to trap the exits using Process.flag/2. it uses erlangs process flag/2 function for the trap_exit flag. When trapping exits(trap_exit is set to true), exit signals will be receive as a tuple message: {:EXIT, from_pid, reason}

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Linking, :explode, [])

    receive do
      {:EXIT, _from_pid, reason} ->
        IO.puts("Exit reason: #{reason}")
    end

    # iex> Linking.run
    # Exit reason: normal
    # :ok
  end
end

# Process Monitoring
# What if we dont want to link two processes but still be kept informed? For that we can use process monitoring with spawn_monitor. When we monitor a process we get a message if the process crashes without our current process crashing or needing to explicitly trap exits.
defmodule Monitoring do
  def explode, do: exit(:kaboom)

  def run do
    spawn_monitor(Monitoring, :explode, [])

    receive do
      {:DOWN, _ref, :process, _from_pid, reason} ->
        IO.puts("Exit reason #{reason}")
    end
  end
end

# Agents
# these are abstractions around background processes maintaining state. We can access them from other processes within our aapplication and node. The state of our Agent is set to our function return value:

# iex> {:ok, agent} = Agent.start_link(fn -> [1,2,3,4] end)
# {:ok, #PID<0.1109.0>}
# iex> Agent.update(agent, fn (state) -> state ++ [5, 6] end)
# :ok
# iex> Agent.get(agent, &(&1))
# [1, 2, 3, 4, 5, 6]

# When we name an agent we can refer to it by that instead of its PID
# iex> Agent.start_link(fn -> [1,2,3] end, name: NumbersList)
# {:ok, #PID<0.1163.0>}
# iex> Agent.get(NumbersList, &(&1))
# [1, 2, 3]

# Tasks -> Provides a way to execute a function in the background and retrieve it's value later, They can be particularly useful when handling expensive operations without blocking the application execution.
defmodule TasksContent do
  def double(x) do
    # erlang timer module
    :timer.sleep(2000)
    x * 2
  end
end

# iex> task = Task.async(TasksContent, :double, [3000])
# %Task{
#   owner: #PID<0.502.0>,
#   pid: #PID<0.1304.0>,
#   ref: #Reference<0.429176559.1135935489.15185>
# }
# Do some work
# iex> Task.await(task)
# 6000
