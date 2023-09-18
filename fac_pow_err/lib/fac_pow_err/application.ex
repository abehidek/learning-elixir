defmodule FacPowErr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @port 4000

  @impl true
  def start(_type, _args) do
    System.no_halt()
    IO.puts("Server listening on port #{@port}")

    children = [
      # Starts a worker by calling: FacPowErr.Worker.start_link(arg)
      # {FacPowErr.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: FacPowErr.Endpoint, port: @port}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FacPowErr.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
