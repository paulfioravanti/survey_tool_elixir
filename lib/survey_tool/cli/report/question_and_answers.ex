defmodule SurveyTool.CLI.Report.QuestionAndAnswers do
  @moduledoc false

  alias TableRex.Table
  alias SurveyTool.{RatingQuestion, SingleSelect}

  @rounding_precision 1

  def row(table, questions) do
    Enum.reduce(questions, table, fn(question, table) ->
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
  defp formatted_answer(%SingleSelect{answers: answers}) do
    answers
    |> Stream.map(fn({key, value}) -> "#{key} (#{value})" end)
    |> Enum.sort()
    |> Enum.join(", ")
  end

  defp formatted_average_score(score) do
    score
    |> Decimal.round(@rounding_precision)
    |> Decimal.to_string()
  end
end
