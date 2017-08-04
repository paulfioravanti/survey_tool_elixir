defmodule SurveyTool.CLI.Report.Title do
  @moduledoc """
  Module representing the overall title for a survey report.
  """

  alias TableRex.Table

  @doc """
  Adds the title to a report table.
  """
  def row(table) do
    table
    |> Table.add_row([""])
    |> Table.add_row(["====================================================="])
    |> Table.add_row(["Questions & Answers by Theme (submitted surveys only)"])
    |> Table.add_row(["====================================================="])
  end
end
