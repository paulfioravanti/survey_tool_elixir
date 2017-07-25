defmodule SurveyTool do
  @moduledoc false

  alias Survey.SingleSelect
  alias Survey.RatingQuestion

  def parse(path) do
    questions =
      path
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> parse_rows()
  end

  defp parse_rows(rows) do
    Enum.map(rows, fn(row) ->
       case row do
         {:ok, row} ->
           row_to_struct(row)
         {:error, reason} ->
           # Error handling?
           IO.puts(reason)
       end
     end)
  end

  defp row_to_struct(row = %{"type" => "ratingquestion"}) do
    %RatingQuestion{text: row["text"], theme: row["theme"]}
  end
  defp row_to_struct(row = %{"type" => "singleselect"}) do
    %SingleSelect{text: row["text"], theme: row["theme"]}
  end
  defp row_to_struct(%{"type" => type}) do
    # Throw error?
    IO.puts("Unknown question type: #{type}")
  end
end
