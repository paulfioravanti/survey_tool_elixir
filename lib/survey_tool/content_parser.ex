defmodule SurveyTool.ContentParser do
  @moduledoc false

  alias SurveyTool.SingleSelect
  alias SurveyTool.RatingQuestion
  alias SurveyTool.Survey

  @answers_range 3..-1
  @rows_per_chunk 1
  @timestamp_index 2

  def generate_survey(csv_filepath) do
    questions =
      csv_filepath
      |> Path.expand()
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> parse_rows()
    %Survey{questions: questions}
  end

  def populate_survey(survey, csv_filepath) do
    csv_filepath
    |> Path.expand()
    |> File.stream!()
    |> CSV.decode()
    |> Stream.chunk(@rows_per_chunk)
    |> populate_answers(survey)
  end

  defp populate_answers(row, survey) do
    Enum.reduce(row, survey, fn(row, survey) ->
      survey = increment(survey, :response_count)
      case timestamped?(row) do
        {:ok, _date, _offset} ->
          survey
          |> increment(:participant_count)
          |> add_answers(row)
        {:error, _message} ->
          survey
      end
    end)
  end

  defp add_answers(survey, row) do
    answered_questions =
      survey.questions
      |> Stream.zip(answers(row))
      |> tally_answers()
    %Survey{survey | questions: answered_questions}
  end

  defp tally_answers(dataset) do
    Enum.map(dataset, fn({question, answer}) ->
      question
      |> question.__struct__.add_answer(answer)
    end)
  end

  defp increment(survey, key) do
    Map.update!(survey, key, fn(current_value) ->
      current_value + 1
    end)
  end

  defp answers([{:ok, row}]) do
    row
    |> Enum.slice(@answers_range)
  end

  defp timestamped?([{:ok, row}]) do
    row
    |> Enum.at(@timestamp_index)
    |> DateTime.from_iso8601()
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
  # defp row_to_struct(%{"type" => type}) do
  #   # Throw error?
  #   IO.puts("Unknown question type: #{type}")
  # end
end
