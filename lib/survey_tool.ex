defmodule SurveyTool do
  @moduledoc false

  # alias SurveyTool.SingleSelect
  # alias SurveyTool.RatingQuestion
  # alias SurveyTool.Survey
  alias SurveyTool.ContentParser

  def parse do
    survey =
      "example-data/survey-2.csv"
      |> ContentParser.generate_survey()
      |> ContentParser.populate_survey("example-data/survey-2-responses.csv")

    # answers =
    #   "../example-data/survey-2-responses.csv"
    #   |> Path.expand(__DIR__)
    #   |> File.stream!()
    #   |> CSV.decode()
    #   |> Stream.chunk(1)
    #   |> Enum.reduce(survey, fn(csv_row, survey) ->
    #        survey =
    #          Map.update!(survey, :response_count, fn(value) -> value + 1 end)
    #        with [{:ok, row}] <- csv_row,
    #             {:ok, _date, _offset} <- timestamped?(row)
    #        do
    #          survey =
    #            Map.update!(survey, :participant_count, fn(value) ->
    #              value + 1
    #            end)
    #          answered_questions =
    #            survey.questions
    #            |> Enum.zip(Enum.slice(row, 3..-1))
    #            |> Enum.map(fn({question, answer}) ->
    #                 question.__struct__.add_answer(question, answer)
    #               end)
    #          Map.update!(survey, :questions, fn(value) ->
    #            answered_questions
    #          end)
    #        else
    #          # Error if:
    #          # - CSV parsing error
    #          # - row not timestamped
    #          {:error, _message} ->
    #            survey
    #        end
    #      end)
  # end

  # defp timestamped?(row) do
  #   row
  #   |> Enum.at(2)
  #   |> DateTime.from_iso8601()
  # end

  # defp parse_rows(rows) do
  #   Enum.map(rows, fn(row) ->
  #      case row do
  #        {:ok, row} ->
  #          row_to_struct(row)
  #        {:error, reason} ->
  #          # Error handling?
  #          IO.puts(reason)
  #      end
  #    end)
  # end

  # defp row_to_struct(row = %{"type" => "ratingquestion"}) do
  #   %RatingQuestion{text: row["text"], theme: row["theme"]}
  # end
  # defp row_to_struct(row = %{"type" => "singleselect"}) do
  #   %SingleSelect{text: row["text"], theme: row["theme"]}
  # end
  # defp row_to_struct(%{"type" => type}) do
  #   # Throw error?
  #   IO.puts("Unknown question type: #{type}")
  end
end
