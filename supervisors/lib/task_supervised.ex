# Tasks have their own Supervisor, the Task.Supervisor. designed for dynamically created tasks, the supervisor uses DynamicSupervisor under the hood

defmodule TaskSupervised do
  def triple(y) do
    :timer.sleep(5000)
    IO.puts(y * 3)
    y * 3
  end

  defmodule TaskSupervisor do
    use Application

    @impl true
    def start(_type, _args) do
      IO.puts("Starting task")

      children = [
        {Task.Supervisor, name: TaskSupervised.TaskSupervisor, restart: :transient}
      ]

      {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

      # the major diff between Supervisor and Task.Supervisor is that its default restart strategy is :temporary (tasks would never be restarted)
      {:ok, pid}
    end
  end
end
