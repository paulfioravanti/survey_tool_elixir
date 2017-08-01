defmodule SurveyTool.CLI.Report.Header do
  @moduledoc false

  alias TableRex.Table

  def row(table) do
    table
    |> Table.add_row(["** SURVEY REPORT **"])
    |> Table.add_row(["==================="])
    |> Table.add_row([""])
  end
end
