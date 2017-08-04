defmodule SurveyTool.CLI.Console do
  @moduledoc """
  Module concerned with outputting content to `stdout`.
  """

  @doc """
  Formats and outputs a message or list of messages to `stdout`.
  """
  def output(message_list = [_head | _tail]) do
    message_list
    |> Enum.map(&formatted_output/1)
    |> Enum.join("\n")
    |> output()
  end
  def output(message) do
    IO.puts(message)
  end

  defp formatted_output({:info, message}) do
    message
  end
  defp formatted_output({:error, message}) do
    [:red, message]
    |> IO.ANSI.format(true)
  end
end
