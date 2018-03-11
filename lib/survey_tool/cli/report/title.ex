defmodule SurveyTool.CLI.Report.Title do
  @moduledoc """
  Module representing the overall title for a survey report.
  """

  alias TableRex.Table

  @doc """
  Adds the title to a report table.

  ## Parameters

    - `table`: The table to add the title to.
  """
  @spec row(Table.t()) :: Table.t()
  def row(table) do
    table
    |> Table.add_row([""])
    |> Table.add_row(["====================================================="])
    |> Table.add_row(["Questions & Answers by Theme (submitted surveys only)"])
    |> Table.add_row(["====================================================="])
  end
end
