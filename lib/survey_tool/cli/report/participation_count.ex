defmodule SurveyTool.CLI.Report.ParticipationCount do
  @moduledoc """
  Module representing the the participation count on a report.
  """

  alias TableRex.Table
  alias SurveyTool.Survey

  @doc """
  Adds the participation count to a report table.

  ## Parameters

    - `table`: The table to add the participation count to.
    - `survey`: The survey from which to calculate the participation count.
  """
  @spec row(Table.t, Survey.t) :: Table.t
  def row(table, survey) do
    table
    |> Table.add_row([content(survey)])
  end

  defp content(survey) do
    "Participation Count:#{String.duplicate("\s", 8)}" <>
    "#{formatted_participation_count(survey)} Submitted"
  end

  defp formatted_participation_count(survey) do
    "#{survey.participant_count}/#{survey.response_count}"
  end
end
