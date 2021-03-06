defmodule SurveyTool.ContentParser do
  @moduledoc """
  Responsible for parsing content in question and answer CSV files.
  """

  alias SurveyTool.{RatingQuestion, SingleSelect, Survey}

  @answers_range 3..-1
  @rows_per_chunk 1
  @question_error_message """
  Could not generate report. Responses file contained \
  unknown question type of: \
  """
  @timestamp_index 2

  @doc """
  Reads and parses the set of questions from a given CSV file
  and initialises a `%Survey{}` struct to hold the resulting list
  of questions.

  ## Parameters:

    - `csv_filepath`: The filepath to the questions CSV file.
  """
  @spec generate_survey(String.t()) :: Survey.t()
  def generate_survey(csv_filepath) do
    questions =
      csv_filepath
      |> Path.expand()
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Enum.map(&to_question/1)

    %Survey{questions: questions}
  end

  @doc """
  Maps responses contained in a given CSV file to questions in
  a `survey` and populates the survey with any relevant answers
  to the questions.

  ## Parameters:

    - `survey`: The survey to populate
    - `csv_filepath`: The filepath to the responses CSV file.
  """
  @spec populate_survey(Survey.t(), String.t()) :: Survey.t()
  def populate_survey(survey, csv_filepath) do
    csv_filepath
    |> Path.expand()
    |> File.stream!()
    |> CSV.decode()
    |> Stream.chunk_every(@rows_per_chunk)
    |> Enum.reduce(survey, &add_response/2)
  end

  defp add_response(response, survey) do
    survey = increment(survey, :response_count)

    case check_timestamp_validity(response) do
      {:ok, _date, _offset} ->
        survey
        |> increment(:participant_count)
        |> populate_answers(response)

      {:error, _message} ->
        survey
    end
  end

  defp populate_answers(survey, row) do
    answered_questions =
      survey.questions
      |> Stream.zip(answers(row))
      |> Enum.map(&add_answer/1)

    %Survey{survey | questions: answered_questions}
  end

  defp add_answer({question, answer}) do
    question
    |> question.__struct__.add_answer(answer)
  end

  defp increment(survey, key) do
    Map.update!(survey, key, fn current_value ->
      current_value + 1
    end)
  end

  defp answers([{:ok, row}]) do
    row
    |> Enum.slice(@answers_range)
  end

  defp check_timestamp_validity([{:ok, response}]) do
    response
    |> Enum.at(@timestamp_index)
    |> DateTime.from_iso8601()
  end

  defp to_question({:ok, row} = {:ok, %{"type" => "ratingquestion"}}) do
    %RatingQuestion{text: row["text"], theme: row["theme"]}
  end

  defp to_question({:ok, row} = {:ok, %{"type" => "singleselect"}}) do
    %SingleSelect{text: row["text"], theme: row["theme"]}
  end

  defp to_question({:ok, %{"type" => type}}) do
    throw({:halt, error: @question_error_message <> type})
  end
end
