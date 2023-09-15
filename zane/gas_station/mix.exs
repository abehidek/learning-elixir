defmodule GasStation.MixProject do
  use Mix.Project

  def project do
    [
      app: :gas_station,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :observer, :wx, :runtime_tools],
      mod: {GasStation.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      # allows to connect to third apis
      {:httpoison, "~> 2.1"},
      # json encoder and decoder
      {:poison, "~> 5.0"},
      # http web server
      {:plug_cowboy, "~> 2.6.1"}
    ]
  end

  defp aliases do
    [
      dev: "run"
    ]
  end
end
