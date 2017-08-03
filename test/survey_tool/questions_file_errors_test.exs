defmodule QuestionsFileErrorsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "Non-existent Questions File" do
    @error_message "Could not generate report: "
                   |> Utilities.error_fragment()

    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.main(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: ["--questions", "non_existent_survey_questions.csv"]
    test "outputs an error message", %{output: output} do
      assert output =~ @error_message
    end
  end

  describe "Questions file with unknown question types" do
    @error_message "Could not generate report. " <>
                   "Unknown question type 'unknown' found in responses file."
                   |> Utilities.error_fragment()

    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.main(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: [
      "--questions",
      "test/fixtures/questions/unknown_question_types.csv"
    ]
    test "outputs an error message", %{output: output} do
      assert output =~ @error_message
    end

  end
end
