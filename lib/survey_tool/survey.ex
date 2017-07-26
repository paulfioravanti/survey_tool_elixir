defmodule SurveyTool.Survey do
  @moduledoc false

  alias __MODULE__, as: Survey

  defstruct questions: [], participant_count: 0, response_count: 0

  # def participation_percentage(%Survey{participant_count: pc, response_count: rc})
  #     when is_nil(pc) or is_nil(rc) do
  #   nil
  # end
  def participation_percentage(survey = %Survey{}) do
    response_count =
      survey.response_count
      |> Decimal.new()

    survey.participant_count
    |> Decimal.new()
    |> Decimal.div(response_count)
    # |> Decimal.round(2)
    # |> Decimal.to_string()
  end
end
