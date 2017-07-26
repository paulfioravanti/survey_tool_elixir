defmodule SurveyTool.Application do
  @moduledoc false

  alias SurveyTool.ContentParser

  def start do
    "example-data/survey-2.csv"
    |> ContentParser.generate_survey()
    |> ContentParser.populate_survey("example-data/survey-2-responses.csv")
  end
end
