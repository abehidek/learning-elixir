# Supervisors => specialized processes with one purpose: monitoring other processes. These supervisors enable us to create fault-tolerant applications by automatically restarting child processes when they fail

# the magic of supervisors is in the "Supervisor.start_link/2" function. In addition to starting our supervisor and children, it allow us to define the strategy our supervisor uses for managing child processes.

# Using the SimpleQueue from the OTP Concurrency Lesson, lets get started.

defmodule SimpleQueueSupervised.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # children can be defined using a list of module names or a list of tuple containing the module name and args
    children = [
      # Starts a worker by calling: SimpleQueueSupervised.Worker.start_link(arg)
      {SimpleQueueSupervised, [1, 2, 3, 4, 5, 6, 7]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleQueueSupervised.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# Strategies => there are three different supervision strategies avaiable to supervisors:
# :one_for_one => Only restart the failed child process.
# :one_for_all => Restart all child processes in the event of failure.
# :rest_for_one => Restart the failed process and any process started after it.

# Child specification => After the supervisor has start, it must know how to start/stop/restart its children. Each child module should have a child_spec/1 function to define these behaviors. The "use GenServer", "use Supervisor" and "use Agent" macros automatically defines this method for us (SimpleQueueSupervised has "use GenServer" so we dont need to modify the module), but if you need to define it yourself, child_spec/1 should return a map of options
