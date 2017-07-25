defmodule SurveyTool.Mixfile do
  use Mix.Project

  def project do
    [
      app: :file_parser,
      deps: deps(),
      elixir: "~> 1.5-rc",
      escript: [main_module: SurveyTool],
      start_permanent: Mix.env == :prod,
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
      # CSV Decoding and Encoding for Elixir
      {:csv, "~> 2.0.0"},
      # Arbitrary precision decimal arithmetic
      {:decimal, "~> 1.0"},
      # Automatically run your Elixir project's tests each time you save a file
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false}
    ]
  end
end
