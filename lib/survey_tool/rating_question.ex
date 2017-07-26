defmodule SurveyTool.RatingQuestion do
  @moduledoc false

  alias __MODULE__, as: RatingQuestion

  defstruct scores: [], text: nil, theme: nil

  @max_score 5
  @min_score 1

  def add_answer(question, ""), do: question
  def add_answer(question = %RatingQuestion{scores: scores}, score) do
    with score <- String.to_integer(score),
         true <- score in (@min_score..@max_score) do
      %RatingQuestion{question | scores: [score | scores]}
    else
      _ ->
    end
  end
  # def add_answer(%RatingQuestion{}, score) do
  #   {:error, "Cannot add value of #{score} to question."}
  # end
  # def add_score(struct, _score) do
  #   {:error, "Cannot add score to #{struct.__struct__}"}
  # end

  def average_score(%RatingQuestion{scores: []}), do: nil
  def average_score(%RatingQuestion{scores: scores}) do
    size =
      scores
      |> length()
      |> Decimal.new()
    score =
      scores
      |> Enum.sum()
      |> Decimal.new()
      |> Decimal.div(size)
  end
end
