defmodule SurveyTool.CLI.Console do
  @moduledoc """
  Module concerned with outputting content to `stdout`.
  """

  @typep messages_list() :: [error: String.t(), info: String.t()]

  @doc """
  Formats and outputs a message or list of messages to `stdout`.

  ## Parameters

    - `messages_list`: The list of messages to output in different formats.
    - `message`: A single message to output to the console.
  """
  @spec output(messages_list | String.t()) :: :ok
  def output(messages_list = [_head | _tail]) do
    messages_list
    |> Enum.map_join("\n", &formatted_output/1)
    |> output()
  end

  def output(message) do
    IO.puts(message)
  end

  defp formatted_output({:info, message}) do
    message
  end

  defp formatted_output({:error, message}) do
    IO.ANSI.format([:red, message], true)
  end
end
