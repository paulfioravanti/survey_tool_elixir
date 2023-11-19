defmodule ResponsesFileBadDataTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "Responses file contains bad rating question data" do
    @report_output "test/fixtures/output/bad_rating_question_responses.txt"
                   |> File.read!()

    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.start(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: [
           "--questions",
           "test/fixtures/questions/only_rating_questions.csv",
           "--responses",
           "test/fixtures/responses/bad_rating_question_responses.csv"
         ]
    test "only valid scores are considered 'submitted'", %{output: output} do
      assert output == @report_output
    end
  end
end
