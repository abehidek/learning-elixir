defmodule GasStation.Plugs.Api do
  import Plug.Conn

  @behaviour Plug

  @impl true
  def init(opts), do: opts

  @impl true
  def call(%Plug.Conn{} = conn, _opts), do: conn |> put_resp_content_type("application/json")
end
