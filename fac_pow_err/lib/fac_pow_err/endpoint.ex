defmodule FacPowErr.Endpoint do
  @moduledoc false
  use Plug.Router

  # import FacPowErr
  import FacPowErr.Utils

  defmodule FacPowErr.Endpoint.Api do
    import Plug.Conn

    @behaviour Plug

    @impl true
    def init(opts), do: opts

    @impl true
    def call(%Plug.Conn{} = conn, _opts), do: conn |> put_resp_content_type("application/json")
  end

  defmodule FacPowErr.Endpoint.RandomError do
    defexception [:message]

    @impl true
    def exception(_value) do
      msg = "Randomly generated error"
      %__MODULE__{message: msg}
    end
  end

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(Plug.Logger)
  plug(:match)
  plug(FacPowErr.Endpoint.Api)
  plug(:dispatch)

  get "/" do
    conn
    |> send_resp(200, Poison.encode!(%{"Hello" => "World", "value" => add(10, 15)}))
  end

  post "/test" do
    %Plug.Conn{body_params: body} = conn

    :timer.sleep(8000)
    # thread_sleep()

    # try do
    %{"value" => number} = body

    res =
      case :rand.uniform(3) do
        1 -> factorial(number) |> IO.inspect(label: "Elixir result")
        2 -> power(number)
        3 -> raise_error()
        # 3 -> raise RandomError
        _ -> raise "unexpected range"
      end

    conn
    |> send_resp(200, Poison.encode!(%{"value" => res}))

    # rescue
    #   MatchError ->
    #     conn
    #     |> send_resp(400, Poison.encode!(%{"message" => "Bad request"}))

    #   FacPowErr.Endpoint.RandomError ->
    #     conn
    #     |> send_resp(500, Poison.encode!(%{"message" => "Random error"}))

    #   _ ->
    #     conn
    #     |> send_resp(500, Poison.encode!(%{"message" => "Internal server error"}))
    # end
  end

  match _ do
    send_resp(conn, 404, Poison.encode!(%{message: "Not found"}))
  end
end
