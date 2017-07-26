defmodule SurveyTool.Survey do
  @moduledoc false

  alias __MODULE__, as: Survey

  defstruct questions: [], participant_count: 0, response_count: 0

  def participation_percentage(survey = %Survey{}) do
    response_count =
      survey.response_count
      |> Decimal.new()

    survey.participant_count
    |> Decimal.new()
    |> Decimal.div(response_count)
  end
end
