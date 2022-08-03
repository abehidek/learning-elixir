defmodule Phxapi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxapiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phxapi.PubSub},
      # Start the Endpoint (http/https)
      PhxapiWeb.Endpoint
      # Start a worker by calling: Phxapi.Worker.start_link(arg)
      # {Phxapi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phxapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
