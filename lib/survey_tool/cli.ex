defmodule SurveyTool.CLI do
  @moduledoc """
  The CLI context boundary.
  """

  alias SurveyTool.CLI.{Console, OptionParser}

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
end
