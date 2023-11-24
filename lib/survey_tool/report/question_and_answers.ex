defmodule SurveyTool.Report.QuestionAndAnswers do
  @moduledoc """
  Module representing the body of a survey question
  and its answers on a report.
  """

  alias SurveyTool.SurveyParser
  alias TableRex.Table

  @typep rating_question() :: SurveyParser.rating_question()
  @typep single_select_question() :: SurveyParser.single_select_question()

  @rounding_precision 1

  @doc """
  Adds a question and its answers to a report table.

  ## Parameters

    - `table`: The table to add the `questions` to.
    - `questions`: The set of questions and answers to add to the `table`.
  """
  @spec row(Table.t(), [rating_question() | single_select_question()]) ::
          Table.t()
  def row(table, questions) do
    Enum.reduce(questions, table, &formatted_row/2)
  end

  defp formatted_row(question, table) do
    table
    |> Table.add_row([""])
    |> Table.add_row(["Q: #{question.text}"])
    |> Table.add_row([formatted_answer(question)])
  end

  defp formatted_answer(question = %_rating_question{scores: scores}) do
    """
    Average Score: #{formatted_average_score(question)} \
    (#{length(scores)} responses submitted)
    """
  end

  defp formatted_answer(%_single_select_question{answers: answers}) do
    answers
    |> Stream.map(fn {key, value} -> "#{key} (#{value})" end)
    |> Enum.sort()
    |> Enum.join(", ")
  end

  defp formatted_average_score(question) do
    question
    |> SurveyParser.average_score()
    |> Decimal.round(@rounding_precision)
    |> Decimal.to_string()
  end
end
