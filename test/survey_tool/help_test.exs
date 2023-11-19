defmodule HelpTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @help_output "lib/survey_tool/cli/help.txt"
               |> Path.expand()
               |> File.read!()
               |> Kernel.<>("\n")

  describe "Help output" do
    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.start(argv) end)
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
