defmodule HelpTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @help_output File.read!(Path.expand("lib/survey_tool/cli/help.txt")) <> "\n"

  describe "Help output" do
    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.main(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: ["--help"]
    test "outputs help using --help option", %{output: output} do
      assert output == @help_output
    end

    @tag argv: ["-h"]
    test "Outputs help using -h alias", %{output: output} do
      assert output == @help_output
    end
  end
end
