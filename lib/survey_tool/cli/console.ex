import Defmodulep, only: [defmodulep: 3]

defmodulep SurveyTool.CLI.Console,
  visible_to: [SurveyTool.CLI, SurveyTool.CLI.Report] do
  @typedoc "List of message types that can be outputted to console."
  @type messages_list() :: [error: String.t(), info: String.t()]

  @doc """
  Formats and outputs a message or list of messages to `stdout`.

  ## Parameters

    - `messages_list`: The list of messages to output in different formats.
    - `message`: A single message to output to the console.
  """
  @spec output(messages_list | String.t()) :: :ok
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
