defmodule Survey.RatingQuestion do
  alias __MODULE__, as: RatingQuestion

  defstruct scores: [], text: nil, theme: nil

  @max_score 5
  @min_score 5

  def add_score(question = %RatingQuestion{scores: scores}, score)
      when is_integer(score) and score in (@min_score..@max_score) do
    {:ok, %RatingQuestion{question | scores: [score | scores]}}
  end
  def add_score(%RatingQuestion{}, score) do
    {:error, "Cannot add value of #{score} to question."}
  end
  # def add_score(struct, _score) do
  #   {:error, "Cannot add score to #{struct.__struct__}"}
  # end

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
    # size =
    #   scores
    #   |> length()
    #   |> Decimal.new()
    # sum
    # |> Decimal.div(size)
    # Decimal.div(Decimal.new(Enum.sum(scores)), Decimal.new(length(scores)))
  end
end
