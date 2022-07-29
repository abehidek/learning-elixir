defmodule ProjectsTest do
  use ExUnit.Case
  doctest Projects

  test "greets the world" do
    assert Projects.hello() == :world
  end
end
