# Supervisors normally start with a list of children to start when the app starts, However sometimes, the supervised children will not be know when our app starts up (for example, we may have a web app that starts a new process to handle a user connecting to our site). For these cases we will want a supervisor where the children can be started on demand. The DynamicSupervisor is used to handle this case.

defmodule SimpleQueueDynamicSupervised.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # children = [
    #   {AsyncQueueSupervised, [1, 2]}
    # ]
    # Since we will not specify children. We only need to define runtime options for the supervisor. The DynamicSupervisor only supports :one_for_all supervision strategy.

    opts = [strategy: :one_for_one, name: SimpleQueueDynamicSupervised.Supervisor]
    DynamicSupervisor.start_link(opts)

    # Then to start SimpleQueueDynamicSupervised dynamically, we'll use "start_child/2" which takes a supervisor and the child specification
    # iex> {:ok, pid} = DynamicSupervisor.start_child(SimpleQueueDynamicSupervised.Supervisor, SimpleQueueDynamicSupervised)
    # iex> {:ok, pid} = DynamicSupervisor.start_child(SimpleQueueDynamicSupervised.Supervisor, {SimpleQueueDynamicSupervised, [3,2,1,0]}) => use a tuple to pass args
  end
end
