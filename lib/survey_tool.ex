defmodule SurveyTool do
  @moduledoc """
  Top level context for SurveyTool API.
  """

  alias SurveyTool.Application

  @doc """
  Delegates to `SurveyTool.Application.start/1` to start the application.

  ## Parameters

    - `argv`: The list of command line arguments.
  """
  defdelegate main(argv), to: Application, as: :start
end
