defmodule SimpleQueueSupervisedTest do
  use ExUnit.Case
  doctest SimpleQueueSupervised

  test "greets the world" do
    assert SimpleQueueSupervised.hello() == :world
  end
end
