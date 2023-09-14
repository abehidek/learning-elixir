defmodule GasStation.Api.Polygon do
  @moduledoc false
  @api_url "https://api.polygonscan.com/api?module=gastracker&action=gasoracle&apikey=YourApiKeyToken"

  def fetch_response do
    case HTTPoison.get(@api_url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        json_resp = Poison.decode!(body)
        {:ok, parse_polygonscan!(json_resp)}

      {_, e} ->
        {:error, e}
    end
  end

  defp parse_polygonscan!(%{"result" => result}) do
    {fast, _} = Float.parse(result["FastGasPrice"])
    {standard, _} = Float.parse(result["ProposeGasPrice"])
    {slow, _} = Float.parse(result["SafeGasPrice"])
    {base_fee, _} = Float.parse(result["suggestBaseFee"])
    {last_block, _} = Float.parse(result["LastBlock"])

    %{
      "fast" => fast,
      "standard" => standard,
      "slow" => slow,
      "base_fee" => base_fee,
      "last_block" => last_block
    }
  end
end
