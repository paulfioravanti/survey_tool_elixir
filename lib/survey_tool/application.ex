defmodule SurveyTool.Application do
  @moduledoc false

  alias SurveyTool.ContentParser
  alias SurveyTool.CLI.{Console, OptionParser, Report}

  def main(argv) do
    try do
      [questions: questions, responses: responses] = OptionParser.parse(argv)
      questions
      |> ContentParser.generate_survey()
      |> ContentParser.populate_survey(responses)
      |> Report.output()
    catch
      :halt ->
        :ok
    rescue
      error in File.Error ->
        Console.output(
          error: "Could not generate report: #{Exception.message(error)}"
        )
      ArgumentError ->
        Console.output(
          error: "Could not generate report. " <>
                 "Check if your responses file fits your questions file."
        )
    end
  end
end
