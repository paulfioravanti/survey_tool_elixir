defmodule SurveyTool.CLI.Report.ParticipationCount do
  @moduledoc false

  alias TableRex.Table

  def row(table, survey) do
    table
    |> Table.add_row([content(survey)])
  end

  defp content(survey) do
    "Participation Count:        " <>
    "#{formatted_participation_count(survey)} Submitted"
  end

  defp formatted_participation_count(survey) do
    "#{survey.participant_count}/#{survey.response_count}"
  end
end
