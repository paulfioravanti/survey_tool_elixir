import Defmodulep, only: [defmodulep: 3]

defmodulep SurveyTool.CLI.Report.ThemeTitle,
  visible_to: [SurveyTool.CLI.Report] do
  alias TableRex.Table

  @divider "-"

  @doc """
  Adds the title for a given theme to a report table.

  ## Parameters

    - `table`: The table to add the theme title to.
    - `theme`: The name of the theme.
  """
  @spec row(Table.t(), String.t()) :: Table.t()
  def row(table, theme) do
    theme_divider =
      theme
      |> String.length()
      |> (fn length -> String.duplicate(@divider, length) end).()

    table
    |> Table.add_row([""])
    |> Table.add_row([theme_divider])
    |> Table.add_row([theme])
    |> Table.add_row([theme_divider])
  end
end
