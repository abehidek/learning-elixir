defmodule GasStation.Endpoint do
  @moduledoc false
  use Plug.Router

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(Plug.Logger)
  plug(:match)
  plug(GasStation.Plugs.Api)
  plug(:dispatch)

  get("/", do: send_resp(conn, 200, Poison.encode!(%{Hello: "World"})))

  get "/gas/eth" do
    {:ok, gas_info} = GasStation.Fetchers.Eth.get()
    send_resp(conn, 200, Poison.encode!(gas_info))
  end

  match _ do
    send_resp(conn, 404, Poison.encode!(%{message: "Not found"}))
  end
end
