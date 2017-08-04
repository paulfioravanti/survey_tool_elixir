defmodule SurveyTool.CLI.Report.Header do
  @moduledoc """
  Module representing the overall header for a report.
  """

  alias TableRex.Table

  @doc """
  Adds the header row to the report table.
  """
  def row(table) do
    table
    |> Table.add_row(["** SURVEY REPORT **"])
    |> Table.add_row(["==================="])
    |> Table.add_row([""])
  end
end
