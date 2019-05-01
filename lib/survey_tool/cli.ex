defmodule SurveyTool.CLI do
  @moduledoc """
  The CLI context boundary.
  """

  import Defmodulep, only: [requirep: 2]
  requirep SurveyTool.CLI.Console, as: Console
  requirep SurveyTool.CLI.OptionParser, as: OptionParser
  requirep SurveyTool.CLI.Report, as: Report

  @doc """
  Delegates to `SurveyTool.CLI.Console.output/1` to format a message or list
  of messages to `stdout`.

  ## Parameters

    - `messages`: The message/s to output
  """
  defdelegate output(messages), to: Console

  @doc """
  Delegates to `SurveyTool.CLI.OptionParser.parse/1` to parse a list of
  arguments.

  ## Parameters

    - `argv`: The list of command line arguments.
  """
  defdelegate parse(argv), to: OptionParser

  @doc """
  Delegates to `SurveyTool.CLI.Report.render_report/1` to output the report
  content to the console.

  ## Parameters

    - `survey`: The survey whose contents are to be output to the console.
  """
  defdelegate render_report(survey), to: Report
end
