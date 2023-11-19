defmodule SurveyTool.Survey do
  @moduledoc """
  Module representing a survey with questions and responses.
  """

  alias __MODULE__, as: Survey
  alias SurveyTool.{RatingQuestion, SingleSelectQuestion}

  defstruct participant_count: 0, questions: [], response_count: 0

  @typedoc "A list of potentially different question types."
  @type questions_list() :: [RatingQuestion.t() | SingleSelectQuestion.t()] | []

  @typedoc "Survey struct type."
  @type t() :: %Survey{
          participant_count: integer,
          questions: questions_list(),
          response_count: integer
        }

  @doc """
  Calculates the percentage of responses in the survey that
  are considered to be participated.

  ## Parameters

    - `survey`: The survey from which to calculate the participation percentage.
  """
  @spec participation_percentage(Survey.t()) :: Decimal.t()
  def participation_percentage(survey = %Survey{}) do
    response_count = Decimal.new(survey.response_count)
    participant_count = Decimal.new(survey.participant_count)
    Decimal.div(participant_count, response_count)
  end
end
