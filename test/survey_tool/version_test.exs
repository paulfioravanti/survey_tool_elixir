defmodule VersionTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @version_output Mix.Project.config()[:version] <> "\n"

  describe "Version number output" do
    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.start(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: ["--version"]
    test "outputs version number using --version option", %{output: output} do
      assert output == @version_output
    end

    @tag argv: ["-v"]
    test "Outputs version number using -v alias", %{output: output} do
      assert output == @version_output
    end
  end
end
