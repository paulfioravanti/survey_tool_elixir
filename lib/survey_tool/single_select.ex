defmodule SurveyTool.SingleSelect do
  @moduledoc """
  Module representing a single select question type question in a survey.
  """

  alias __MODULE__, as: SingleSelect

  defstruct answers: %{}, text: nil, theme: nil

  @doc """
  Adds an answer to a given question and keeps a tally of how
  many times the answer occurs for the question.
  """
  def add_answer(question = %SingleSelect{answers: answers}, answer) do
    answers =
      answers
      |> Map.has_key?(answer)
      |> record_answer(answers, answer)
    %SingleSelect{question | answers: answers}
  end

  defp record_answer(true, answers, answer) do
    %{answers | answer => answers[answer] + 1}
  end
  defp record_answer(false, answers, answer) do
    Map.put(answers, answer, 1)
  end
end
