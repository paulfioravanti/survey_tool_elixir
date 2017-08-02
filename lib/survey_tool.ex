defmodule SurveyTool do
  @moduledoc false

  alias SurveyTool.Application

  defdelegate main(argv), to: Application
end
