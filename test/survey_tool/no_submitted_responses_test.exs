defmodule NoSubmittedResponsesTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @report_output File.read!(
    "test/fixtures/output/no_submitted_responses_output.txt"
  )

  describe "Generating a report when no responses are submitted" do
    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.main(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: [
           "--questions",
           "test/fixtures/questions/no_submitted_questions.csv",
           "--responses",
           "test/fixtures/responses/no_submitted_responses.csv"
         ]
    test "a blank report is outputted to stdout", %{output: output} do
      assert output == @report_output
    end
  end
end
