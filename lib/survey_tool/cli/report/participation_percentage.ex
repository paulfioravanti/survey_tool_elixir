defmodule SurveyTool.CLI.Report.ParticipationPercentage do
  @moduledoc """
  Module representing the participation percentage on a report.
  """

  alias TableRex.Table
  alias SurveyTool.Survey

  @percent_multiplier Decimal.new(100)
  @rounding_precision 2

  @doc """
  Adds the participation percentage to the report table.

  ## Parameters

    - `table`: The table to add the participation percentage to.
    - `survey`: The survey from which to calculate the participation percentage.
  """
  @spec row(Table.t, Survey.t) :: Table.t
  def row(table, survey) do
    content =
      survey
      |> Survey.participation_percentage()
      |> percentage_row()
    table
    |> Table.add_row([content])
  end

  defp percentage_row(percent) do
    "Participation Percentage:#{String.duplicate("\s", 3)}" <>
    formatted_percentage(percent)
  end

  defp formatted_percentage(percent) do
    percent
    |> Decimal.mult(@percent_multiplier)
    |> Decimal.round(@rounding_precision)
    |> Decimal.to_string()
    |> Kernel.<>("%")
  end
end
