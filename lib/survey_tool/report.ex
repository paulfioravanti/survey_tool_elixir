defmodule SurveyTool.Report do
  @moduledoc """
  Module representing a survey report.
  """

  alias SurveyTool.Report.Table

  @doc """
  Delegates to `SurveyTool.Report.Table.render/1` to output a report to the
  console.

  ## Parameters

    - `survey`: The survey whose contents are to be output to the console.
  """
  defdelegate render(survey), to: Table
end
