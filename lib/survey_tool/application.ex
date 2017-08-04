defmodule SurveyTool.Application do
  @moduledoc """
  The entry point for the Survey Tool to run.
  """

  alias SurveyTool.ContentParser
  alias SurveyTool.CLI.{Console, OptionParser, Report}

  @doc """
  Starts the survey tool, performs all operations, and handles any
  premature exiting of the program.
  """
  def start(argv) do
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
