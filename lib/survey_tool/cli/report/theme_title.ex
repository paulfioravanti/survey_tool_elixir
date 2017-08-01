defmodule SurveyTool.CLI.Report.ThemeTitle do
  @moduledoc false

  alias TableRex.Table

  def row(table, theme) do
    theme_divider =
      "-"
      |> String.duplicate(String.length(theme))
    table
    |> Table.add_row([""])
    |> Table.add_row([theme_divider])
    |> Table.add_row([theme])
    |> Table.add_row([theme_divider])
  end
end
