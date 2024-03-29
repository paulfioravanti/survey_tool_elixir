defmodule SurveyTool.SurveyParser.RatingQuestion do
  @moduledoc """
  Module representing a rating question type question in a survey.
  """

  alias __MODULE__, as: RatingQuestion

  defstruct scores: [], text: nil, theme: nil

  @typedoc "Rating question struct type."
  @type t() :: %RatingQuestion{
          scores: scores(),
          text: optional_string(),
          theme: optional_string()
        }
  @typep scores() :: [integer] | []
  @typep optional_string() :: String.t() | nil

  @max_score 5
  @min_score 1

  @doc """
  Adds an answer to a given `question`.

  ## Parameters

    - `question`: The `RatingQuestion` to add the score to.
    - `score`: The score value to add.

  ## Validations

  An answer will only be added to the question under the
  following conditions:

    - the answer is not `nil`
    - the answer is an integer
    - the answer falls with the accepted numerical range
  """
  @spec add_answer(RatingQuestion.t(), String.t()) :: RatingQuestion.t()
  def add_answer(question = %RatingQuestion{}, ""), do: question

  def add_answer(question = %RatingQuestion{scores: scores}, score) do
    with score <- String.to_integer(score),
         true <- score in @min_score..@max_score do
      %RatingQuestion{question | scores: [score | scores]}
    else
      _invalid_score ->
        question
    end
  end

  @doc """
  Calculates the average score for a given question.
  No score is calculated for questions that have no scores.

  ## Parameters

    - `question`: The question from which to get the scores to calculate
      the average score.
  """
  @spec average_score(RatingQuestion.t()) :: Decimal.t()
  def average_score(%RatingQuestion{scores: []}), do: Decimal.new(0)

  def average_score(%RatingQuestion{scores: scores}) do
    size = Decimal.new(length(scores))
    scores = Decimal.new(Enum.sum(scores))
    Decimal.div(scores, size)
  end
end
