defmodule AppTest do
  use ExUnit.Case
  doctest App

  test "greets the world" do
    assert App.hello() == :world
  end

  test "test hello world" do
    assert App.hello_world() == :ok
  end
end
