defmodule SurveyTool.Mixfile do
  use Mix.Project

  def project do
    [
      app: :survey_tool,
      deps: deps(),
      dialyzer: [plt_add_deps: :project],
      docs: [
        main: "SurveyTool",
        extras: ["README.md"]
      ],
      elixir: "~> 1.8",
      escript: escript(),
      name: "Survey Tool",
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      source_url: "https://github.com/paulfioravanti/survey_tool_elixir",
      start_permanent: Mix.env() == :prod,
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
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      # CSV Decoding and Encoding for Elixir
      {:csv, "~> 2.3"},
      # Arbitrary precision decimal arithmetic
      {:decimal, "~> 1.7"},
      # API for defining and requiring private modules
      {:defmodulep, "~> 0.1", github: "josevalim/defmodulep"},
      # Mix tasks to simplify use of Dialyzer in Elixir projects.
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      # Coverage report tool for Elixir
      {:excoveralls, "~> 0.11", only: :test},
      # ExDoc produces HTML and EPUB documentation for Elixir projects
      {:ex_doc, "~> 0.20", only: [:dev, :test], runtime: false},
      # A Mix task that gives you hints where to improve your inline docs.
      {:inch_ex, "~> 2.0", only: [:dev, :test]},
      # Automatically run your Elixir project's tests each time you save a file
      {:mix_test_watch, "~> 0.9", only: :dev, runtime: false},
      # Generate text-based tables for display
      {:table_rex, "~> 2.0"}
    ]
  end

  defp escript do
    [
      main_module: SurveyTool,
      path: "bin/survey-tool"
    ]
  end
end
