defmodule PTV.MixProject do
  use Mix.Project

  def project do
    [
      app: :ptv,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bypass, "~> 1.0"},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 1.4"},
      {:ex_doc, "~> 0.18"},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end
end
