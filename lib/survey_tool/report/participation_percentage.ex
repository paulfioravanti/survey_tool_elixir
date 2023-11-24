defmodule SurveyTool.Report.ParticipationPercentage do
  @moduledoc """
  Module representing the participation percentage on a report.
  """

  alias SurveyTool.SurveyParser
  alias TableRex.Table

  @typep survey() :: SurveyParser.survey()

  @percent_multiplier Decimal.new(100)
  @rounding_precision 2
  @spacer String.duplicate("\s", 3)

  @doc """
  Adds the participation percentage to the report table.

  ## Parameters

    - `table`: The table to add the participation percentage to.
    - `survey`: The survey from which to calculate the participation percentage.
  """
  @spec row(Table.t(), survey()) :: Table.t()
  def row(table, survey) do
    Table.add_row(table, [content(survey)])
  end

  defp content(survey) do
    survey
    |> SurveyParser.participation_percentage()
    |> percentage_row()
  end

  defp percentage_row(percent) do
    "Participation Percentage:" <> @spacer <> formatted_percentage(percent)
  end

  defp formatted_percentage(percent) do
    percent
    |> Decimal.mult(@percent_multiplier)
    |> Decimal.round(@rounding_precision)
    |> Decimal.to_string()
    |> Kernel.<>("%")
  end
end
