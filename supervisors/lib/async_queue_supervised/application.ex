defmodule AsyncQueueSupervised.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {AsyncQueueSupervised, [1, 2]}
    ]

    opts = [strategy: :one_for_one, name: AsyncQueueSupervised.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
