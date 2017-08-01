defmodule SurveyTool.CLI.Report.ParticipationPercentage do
  @moduledoc false

  alias TableRex.Table
  alias SurveyTool.Survey

  @percent_multiplier Decimal.new(100)
  @rounding_precision 2

  def row(table, survey) do
    percent = Survey.participation_percentage(survey)
    table
    |> Table.add_row([content(percent)])
  end

  defp content(percent) do
    "Participation Percentage:\t#{formatted_percentage(percent)}"
  end

  defp formatted_percentage(percent) do
    percent
    |> Decimal.mult(@percent_multiplier)
    |> Decimal.round(@rounding_precision)
    |> Decimal.to_string()
    |> Kernel.<>("%")
  end
end
