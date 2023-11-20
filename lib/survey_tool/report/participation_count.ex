defmodule SurveyTool.Report.ParticipationCount do
  @moduledoc """
  Module representing the the participation count on a report.
  """

  alias SurveyTool.SurveyParser
  alias TableRex.Table

  @type survey :: SurveyParser.survey()

  @spacer String.duplicate("\s", 8)

  @doc """
  Adds the participation count to a report table.

  ## Parameters

    - `table`: The table to add the participation count to.
    - `survey`: The survey from which to calculate the participation count.
  """
  @spec row(Table.t(), survey) :: Table.t()
  def row(table, survey) do
    content = participation_count_row(survey)
    Table.add_row(table, [content])
  end

  defp participation_count_row(survey) do
    "Participation Count:" <>
      @spacer <>
      formatted_participation_count(survey) <>
      " Submitted"
  end

  defp formatted_participation_count(survey) do
    "#{survey.participant_count}/#{survey.response_count}"
  end
end
