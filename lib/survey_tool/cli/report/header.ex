import Defmodulep, only: [defmodulep: 3]

defmodulep SurveyTool.CLI.Report.Header, visible_to: [SurveyTool.CLI.Report] do
  alias TableRex.Table

  @doc """
  Adds the header row to the report table.

  ## Parameters

    - `table`: The table to add the header to.
  """
  @spec row(Table.t()) :: Table.t()
  def row(table) do
    table
    |> Table.add_row(["** SURVEY REPORT **"])
    |> Table.add_row(["==================="])
    |> Table.add_row([""])
  end
end
