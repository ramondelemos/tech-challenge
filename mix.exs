defmodule FinancialSystem.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @github_url "https://github.com/ramondelemos/tech-challenge"

  def project do
    [
      app: :financial_system,
      name: "FinancialSystem",
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.8.1", only: [:dev, :test]},
      {:credo, "~> 0.8.10", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.18", only: [:dev, :docs], runtime: false},
      {:ex_dinheiro, "~> 0.1.7"}
    ]
  end

  defp description do
    """
    Tech Challenge Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Ramon de Lemos"],
      contributors: ["Ramon de Lemos"],
      links: %{"GitHub" => @github_url}
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      source_url: @github_url,
      main: "FinancialSystem",
      extras: ["README.md"]
    ]
  end
end
