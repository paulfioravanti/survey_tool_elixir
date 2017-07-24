defmodule SurveyToolTest do
  use ExUnit.Case
  doctest SurveyTool

  test "greets the world" do
    assert SurveyTool.hello() == :world
  end
end
