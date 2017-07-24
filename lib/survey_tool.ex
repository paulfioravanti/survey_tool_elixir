defmodule SurveyTool do
  @moduledoc false

  def parse(path) do
    path
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode(headers: true)
  end
end
