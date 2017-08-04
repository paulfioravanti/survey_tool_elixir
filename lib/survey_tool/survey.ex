defmodule SurveyTool.Survey do
  @moduledoc """
  Module representing a survey with questions and responses.
  """

  alias __MODULE__, as: Survey

  defstruct questions: [], participant_count: 0, response_count: 0

  @doc """
  Calculates the percentage of responses in the survey that
  are considered to be participated.
  """
  def participation_percentage(survey = %Survey{}) do
    response_count =
      survey.response_count
      |> Decimal.new()

    survey.participant_count
    |> Decimal.new()
    |> Decimal.div(response_count)
  end
end
