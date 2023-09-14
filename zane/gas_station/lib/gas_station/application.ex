defmodule GasStation.Application do
  @moduledoc false
  use Application
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications

  @port 4000

  @impl true
  def start(_type, _args) do
    System.no_halt(true)
    IO.puts("Server listening on port #{@port}")

    children = [
      # Starts a worker by calling: GasStation.Worker.start_link(arg)
      # {GasStation.Worker, arg}
      GasStation.Fetchers.Eth,
      GasStation.Fetchers.Polygon,
      {Plug.Cowboy, scheme: :http, plug: GasStation.Endpoint, port: @port}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GasStation.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
