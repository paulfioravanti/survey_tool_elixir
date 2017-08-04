defmodule SurveyTool.CLI.Report.ThemeTitle do
  @moduledoc """
  Module representing the theme title of a set of questions
  on a report.
  """

  alias TableRex.Table

  @divider "-"

  @doc """
  Adds the title for a given theme to a report table.
  """
  def row(table, theme) do
    theme_divider =
      @divider
      |> String.duplicate(String.length(theme))
    table
    |> Table.add_row([""])
    |> Table.add_row([theme_divider])
    |> Table.add_row([theme])
    |> Table.add_row([theme_divider])
  end
end
