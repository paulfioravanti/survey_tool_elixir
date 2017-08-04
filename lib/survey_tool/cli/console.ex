defmodule SurveyTool.CLI.Console do
  @moduledoc """
  Module concerned with outputting content to `stdout`.
  """

  @typedoc "List of message types that can be outputted to console."
  @type messages_list() :: [error: String.t, info: String.t]

  @doc """
  Formats and outputs a message or list of messages to `stdout`.
  """
  @spec output(messages_list | String.t) :: :ok
  def output(messages_list = [_head | _tail]) do
    messages_list
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
