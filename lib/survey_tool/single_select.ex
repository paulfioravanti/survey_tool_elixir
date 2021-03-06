defmodule SurveyTool.SingleSelect do
  @moduledoc """
  Module representing a single select question type question in a survey.
  """

  alias __MODULE__, as: SingleSelect

  defstruct answers: %{}, text: nil, theme: nil

  @typedoc """
  An optional map of answers to their tally of occurances in a set
  of responses
  """
  @type answers() :: %{required(String.t()) => integer} | %{}

  @typedoc "Optional string"
  @type optional_string() :: String.t() | nil

  @typedoc "Single select question struct type."
  @type t() :: %SingleSelect{
          answers: answers(),
          text: optional_string(),
          theme: optional_string()
        }

  @doc """
  Adds an answer to a given question and keeps a tally of how
  many times the answer occurs for the question.

  ## Parameters

    - `question`: The question whose `answers` to add the `answer` to.
    - `answer`: The answer to add to the question.
  """
  @spec add_answer(SingleSelect.t(), String.t()) :: SingleSelect.t()
  def add_answer(question = %SingleSelect{answers: answers}, answer) do
    answers =
      answers
      |> Map.update(answer, 1, fn count -> count + 1 end)

    %SingleSelect{question | answers: answers}
  end
end
