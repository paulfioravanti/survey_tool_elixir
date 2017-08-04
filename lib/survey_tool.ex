defmodule SurveyTool do
  @moduledoc """
  Top level context for SurveyTool API.
  """

  alias SurveyTool.Application

  defdelegate main(argv), to: Application, as: :start
end
