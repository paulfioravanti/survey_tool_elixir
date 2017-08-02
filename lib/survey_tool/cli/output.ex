defmodule SurveyTool.CLI.Output do
  def messages(messages) do
    messages
    |> Stream.map(&formatted_output/1)
    |> Enum.join("\n")
    |> message()
  end

  def message(message) do
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
