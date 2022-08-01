defmodule Mix.Tasks.Hello do
  @moduledoc """
  The hello mix task: `mix help hello`
  """
  use Mix.Task

  @shortdoc "Simply calls the Hello.say/o function"
  @impl Mix.Task
  def run(_) do
    Mix.Task.run("app.start")
    Hello.say()
  end
end
