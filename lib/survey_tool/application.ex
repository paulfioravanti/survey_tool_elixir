defmodule SurveyTool.Application do
  @moduledoc """
  The entry point for the Survey Tool to run.
  """

  alias SurveyTool.ContentParser
  alias SurveyTool.CLI.{Console, OptionParser, Report}

  @file_error_message "Could not generate report: "
  @argument_error_message """
  Could not generate report. \
  Check if your responses file fits your questions file.\
  """

  @doc """
  Starts the survey tool, performs all operations, and handles any
  premature exiting of the program.

  ## Parameters

    - `argv`: The list of command line arguments.
  """
  @spec start([String.t()] | []) :: :ok
  def start(argv) do
    [questions: questions, responses: responses] = OptionParser.parse(argv)

    questions
    |> ContentParser.generate_survey()
    |> ContentParser.populate_survey(responses)
    |> Report.output()
  rescue
    error in File.Error ->
      Console.output(error: @file_error_message <> Exception.message(error))

    ArgumentError ->
      Console.output(error: @argument_error_message)
  catch
    :halt ->
      :ok
  end
end
