defmodule SurveyTool.CLI.Report.ParticipationCount do
  @moduledoc """
  Module representing the the participation count on a report.
  """

  alias TableRex.Table

  @doc """
  Adds the participation count to a report table.
  """
  def row(table, survey) do
    table
    |> Table.add_row([content(survey)])
  end

  defp content(survey) do
    "Participation Count:\s\s\s\s\s\s\s\s" <>
    "#{formatted_participation_count(survey)} Submitted"
  end

  defp formatted_participation_count(survey) do
    "#{survey.participant_count}/#{survey.response_count}"
  end
end
