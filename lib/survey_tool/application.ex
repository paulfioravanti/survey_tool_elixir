defmodule SurveyTool.Application do
  @moduledoc """
  The entry point for the Survey Tool to run.
  """

  alias SurveyTool.CLI
  alias SurveyTool.ContentParser

  @argument_error_message """
  Could not generate report. \
  Check if your responses file fits your questions file.\
  """
  @file_error_message "Could not generate report: "

  @doc """
  Starts the survey tool, performs all operations, and handles any
  premature exiting of the program.

  ## Parameters

    - `argv`: The list of command line arguments.
  """
  @spec start([String.t()] | []) :: :ok
  def start(argv) do
    case CLI.parse(argv) do
      {:ok, questions: questions, responses: responses} ->
        questions
        |> ContentParser.generate_survey()
        |> ContentParser.populate_survey(responses)
        |> CLI.render_report()

      {status, messages} when status in [:info, :error] ->
        CLI.output(messages)
    end
  rescue
    error in File.Error ->
      CLI.output(error: @file_error_message <> Exception.message(error))

    ArgumentError ->
      CLI.output(error: @argument_error_message)
  catch
    {:halt, messages} ->
      CLI.output(messages)
  end
end
