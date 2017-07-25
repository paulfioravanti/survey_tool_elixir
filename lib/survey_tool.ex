defmodule SurveyTool do
  @moduledoc false

  alias SurveyTool.SingleSelect
  alias SurveyTool.RatingQuestion

  def parse do
    questions =
      # path
      "../example-data/survey-2.csv"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> parse_rows()

    participant_count = response_count = 0
    survey_map = %{
      questions: questions,
      participant_count: 0,
      response_count: 0
    }
    answers =
      "../example-data/survey-2-responses.csv"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode()
      # |> Enum.map(fn(row) ->
      #      with {:ok, row} <- row do
      #        row
      #      end
      #    end)
      |> Enum.reduce(survey_map, fn(csv_row, survey) ->
           survey =
             Map.update!(survey, :response_count, fn(value) -> value + 1 end)
           with {:ok, row} <- csv_row,
                {:ok, _date, _offset} <- timestamped?(row) do
             survey =
               Map.update!(survey, :participant_count, fn(value) ->
                 value + 1
               end)
             answered_questions =
               survey.questions
               |> Enum.zip(Enum.slice(row, 3..-1))
               |> Enum.map(fn({question, answer}) ->
                    question.__struct__.add_answer(question, answer)
                  end)
             Map.update!(survey, :questions, fn(value) ->
               answered_questions
             end)
           else
             # Error if:
             # - CSV parsing error
             # - row not timestamped
             {:error, _message} ->
               survey
           end
         end)

      # |> Stream.chunk(5)
      # |> Enum.map(fn(row) ->
      #      with {:ok, row} <- row do
      #        response_count = response_count + 1
      #        with {:ok, _date, _offset} <- DateTime.from_iso8601(Enum.at(row, 2)) do
      #          participant_count = participant_count + 1
      #          questions
      #          |> Enum.zip(Enum.slice(row, 3..-1))
      #          |> Enum.map(fn({question, answer}) ->
      #               question.__struct__.add_answer(question, answer)
      #             end)
      #        end
      #      end
      #    end)
    # IO.inspect(response_count)
    # IO.inspect(participant_count)
    # IO.inspect(questions)
    # IO.inspect(answers)
    # # Survey.new(questions, participant_count, response_count)
  end

  defp timestamped?(row) do
    row
    |> Enum.at(2)
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
  defp row_to_struct(%{"type" => type}) do
    # Throw error?
    IO.puts("Unknown question type: #{type}")
  end
end
