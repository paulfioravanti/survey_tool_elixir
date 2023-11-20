defmodule SurveyTool.SurveyParser do
  @moduledoc """
  Responsible for parsing content in question and answer CSV files.
  """

  alias SurveyTool.SurveyParser.{RatingQuestion, SingleSelectQuestion, Survey}

  @answers_range 3..-1
  @rows_per_chunk 1
  @question_error_message """
  Could not generate report. Responses file contained \
  unknown question type of: \
  """
  @rating_question "ratingquestion"
  @single_select_question "singleselect"
  @timestamp_index 2

  @type survey :: Survey.t()
  @type rating_question :: RatingQuestion.t()
  @type single_select_question :: SingleSelectQuestion.t()

  @doc """
  Delegates to `SurveyTool.SurveyParser.RatingQuestion.average_score()` to
  calculate the average score for a given question.

  ## Parameters

    - `question`: The question from which to get the scores to calculate
      the average score.
  """
  defdelegate average_score(question), to: RatingQuestion

  @doc """
  Delegates to `SurveyTool.SurveyParser.Survey.participation_percentage()` to
  calculate the percentage of responses in the survey that are considered to be
  participated.

  ## Parameters

    - `survey`: The survey whose percentage to calculate
  """
  defdelegate participation_percentage(survey), to: Survey

  @doc """
  Reads and parses the set of questions from a given CSV file
  and initialises a `%Survey{}` struct to hold the resulting list
  of questions.

  ## Parameters:

    - `csv_filepath`: The filepath to the questions CSV file.
  """
  @spec generate_survey(String.t()) :: Survey.t()
  def generate_survey(csv_filepath) do
    %Survey{questions: generate_survey_questions(csv_filepath)}
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
    |> decode_csv(headers: false)
    |> Stream.chunk_every(@rows_per_chunk)
    |> Enum.reduce(survey, &add_response/2)
  end

  defp generate_survey_questions(csv_filepath) do
    csv_filepath
    |> decode_csv(headers: true)
    |> Enum.map(&to_question/1)
  end

  defp decode_csv(csv_filepath, headers: headers) do
    csv_filepath
    |> Path.expand()
    |> File.stream!()
    |> CSV.decode(headers: headers)
  end

  defp add_response(response, survey) do
    survey = increment(survey, :response_count)

    case check_timestamp_validity(response) do
      {:ok, _date, _offset} ->
        add_valid_response(survey, response)

      {:error, _message} ->
        survey
    end
  end

  defp add_valid_response(survey, response) do
    survey
    |> increment(:participant_count)
    |> populate_answers(response)
  end

  defp populate_answers(survey, response) do
    %Survey{survey | questions: generate_answered_questions(survey, response)}
  end

  defp generate_answered_questions(survey, response) do
    survey.questions
    |> Stream.zip(answers(response))
    |> Enum.map(&add_answer/1)
  end

  defp add_answer({question, answer}) do
    question.__struct__.add_answer(question, answer)
  end

  defp increment(survey, key), do: Map.update!(survey, key, &(&1 + 1))

  defp answers([{:ok, response}]), do: Enum.slice(response, @answers_range)

  defp check_timestamp_validity([{:ok, response}]) do
    response
    |> Enum.at(@timestamp_index)
    |> DateTime.from_iso8601()
  end

  defp to_question({:ok, response} = {:ok, %{"type" => @rating_question}}) do
    %RatingQuestion{text: response["text"], theme: response["theme"]}
  end

  defp to_question(
         {:ok, response} = {:ok, %{"type" => @single_select_question}}
       ) do
    %SingleSelectQuestion{text: response["text"], theme: response["theme"]}
  end

  defp to_question({:ok, %{"type" => type}}) do
    throw({:halt, error: @question_error_message <> type})
  end
end
