defmodule SurveyTool.CLI.Report.QuestionAndAnswers do
  @moduledoc false

  alias TableRex.Table
  alias SurveyTool.{RatingQuestion, SingleSelect}

  def row(table, questions) do
    Enum.reduce(questions, table, fn(question, table) ->
      table
      |> Table.add_row([""])
      |> Table.add_row(["Q: #{question.text}"])
      |> Table.add_row([formatted_answer(question)])
    end)
  end

  defp formatted_answer(question = %RatingQuestion{scores: scores}) do
    """
    Average Score: #{RatingQuestion.average_score(question)}
    (#{length(scores)} responses submitted)
    """
    |> String.replace("\n", " ")
  end
  defp formatted_answer(%SingleSelect{answers: answers}) do
    answers
    |> Stream.map(fn({key, value}) -> "#{key} (#{value})" end)
    |> Enum.sort()
    |> Enum.join(", ")
  end
end
