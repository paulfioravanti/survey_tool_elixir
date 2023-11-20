defmodule SurveyTool.Report.QuestionAndAnswers do
  @moduledoc """
  Module representing the body of a survey question
  and its answers on a report.
  """

  alias TableRex.Table
  alias SurveyTool.SurveyParser.{RatingQuestion, SingleSelectQuestion}

  @rounding_precision 1

  @doc """
  Adds a question and its answers to a report table.

  ## Parameters

    - `table`: The table to add the `questions` to.
    - `questions`: The set of questions and answers to add to the `table`.
  """
  @spec row(Table.t(), [RatingQuestion.t() | SingleSelectQuestion.t()]) ::
          Table.t()
  def row(table, questions) do
    Enum.reduce(questions, table, fn question, table ->
      table
      |> Table.add_row([""])
      |> Table.add_row(["Q: #{question.text}"])
      |> Table.add_row([formatted_answer(question)])
    end)
  end

  defp formatted_answer(question = %RatingQuestion{scores: scores}) do
    average_score =
      question
      |> RatingQuestion.average_score()
      |> formatted_average_score()

    "Average Score: #{average_score} (#{length(scores)} responses submitted)"
  end

  defp formatted_answer(%SingleSelectQuestion{answers: answers}) do
    answers
    |> Stream.map(fn {key, value} -> "#{key} (#{value})" end)
    |> Enum.sort()
    |> Enum.join(", ")
  end

  defp formatted_average_score(score) do
    score
    |> Decimal.round(@rounding_precision)
    |> Decimal.to_string()
  end
end
