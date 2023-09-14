defmodule ApiEthTest do
  use ExUnit.Case
  doctest Api.Eth

  test "get and parse eth api result" do
    response = Api.Eth.fetch_response()
    assert match?({:ok, %{"fast" => _}}, response)
  end
end
