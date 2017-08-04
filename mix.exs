defmodule SurveyTool.Mixfile do
  use Mix.Project

  def project do
    [
      app: :survey_tool,
      deps: deps(),
      elixir: "~> 1.5",
      escript: escript(),
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.1.0"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # A static code analysis tool for the Elixir language
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      # CSV Decoding and Encoding for Elixir
      {:csv, "~> 2.0.0"},
      # Arbitrary precision decimal arithmetic
      {:decimal, "~> 1.0"},
      # A code style linter for Elixir, powered by shame
      {:dogma, "~> 0.1", only: [:dev, :test]},
      # Coverage report tool for Elixir
      {:excoveralls, "~> 0.7", only: :test},
      # ExDoc produces HTML and EPUB documentation for Elixir projects
      {:ex_doc, "~> 0.14", only: [:dev, :test], runtime: false},
      # Automatically run your Elixir project's tests each time you save a file
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
      # Generate text-based tables for display
      {:table_rex, "~> 0.10"}
    ]
  end

  defp escript do
    [
      main_module: SurveyTool,
      path: "bin/survey-tool"
    ]
  end
end
