defmodule SurveyTool do
  @moduledoc false

  alias SurveyTool.Application

  defdelegate start, to: Application
end
