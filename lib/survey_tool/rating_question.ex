defmodule SurveyTool.RatingQuestion do
  @moduledoc """
  Module representing a rating question type question in a survey.
  """

  alias __MODULE__, as: RatingQuestion

  defstruct scores: [], text: nil, theme: nil

  @max_score 5
  @min_score 1

  @doc """
  Adds an answer to a given `question` if:

  - the answer is not `nil`
  - the answer is an integer
  - the answer falls with the accepted numerical range
  """
  def add_answer(question, ""), do: question
  def add_answer(question = %RatingQuestion{scores: scores}, score) do
    with score <- String.to_integer(score),
         true <- score in (@min_score..@max_score) do
      %RatingQuestion{question | scores: [score | scores]}
    else
      _ ->
        question
    end
  end

  @doc """
  Calculates the average score for a given question.
  No score is calculated for questions that have no scores.
  """
  def average_score(%RatingQuestion{scores: []}), do: nil
  def average_score(%RatingQuestion{scores: scores}) do
    size =
      scores
      |> length()
      |> Decimal.new()
    scores
    |> Enum.sum()
    |> Decimal.new()
    |> Decimal.div(size)
  end
end
