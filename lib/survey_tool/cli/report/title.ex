defmodule SurveyTool.CLI.Report.Title do
  @moduledoc false

  alias TableRex.Table

  def row(table) do
    table
    |> Table.add_row([""])
    |> Table.add_row(["Questions & Answers by Theme (submitted surveys only)"])
    |> Table.add_row(["====================================================="])
  end
end
