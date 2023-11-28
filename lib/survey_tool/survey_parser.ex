defmodule SurveyTool.SurveyParser do
  @moduledoc """
  Responsible for parsing content in question and answer CSV files.
  """

  alias SurveyTool.SurveyParser.{
    Generator,
    RatingQuestion,
    SingleSelectQuestion,
    Survey
  }

  @type survey() :: Survey.t()
  @opaque rating_question() :: RatingQuestion.t()
  @opaque single_select_question() :: SingleSelectQuestion.t()

  @doc """
  Delegates to `SurveyTool.SurveyParser.RatingQuestion.average_score/1` to
  calculate the average score for a given question.

  ## Parameters

    - `question`: The question from which to get the scores to calculate
      the average score.
  """
  defdelegate average_score(question), to: RatingQuestion

  @doc """
  Delegates to `SurveyTool.SurveyParser.Survey.participation_percentage/1` to
  calculate the percentage of responses in the survey that are considered to be
  participated.

  ## Parameters

    - `survey`: The survey whose percentage to calculate
  """
  defdelegate participation_percentage(survey), to: Survey

  @doc """
  Delegates to `SurveyTool.SurveyParser.Generator.generate_survey/1` to
  reads and parse the set of questions from a given CSV file.

  ## Parameters:

    - `csv_filepath`: The filepath to the questions CSV file.
  """
  defdelegate generate_survey(survey), to: Generator

  @doc """
  Delegates to `SurveyTool.SurveyParser.Generator.populate_survey/2` to
  map responses contained in a given CSV file to questions in
  a `survey` and populates the survey with any relevant answers
  to the questions.

  ## Parameters:

    - `survey`: The survey to populate
    - `csv_filepath`: The filepath to the responses CSV file.
  """
  defdelegate populate_survey(survey, csv_filepath), to: Generator
end
