defmodule QuestionsFileErrorsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  setup(%{argv: argv}) do
    output = capture_io(fn -> SurveyTool.main(argv) end)
    {:ok, [output: output]}
  end

  describe "Non-existent Questions File" do
    @error_message Utilities.error_fragment("Could not generate report: ")

    @tag argv: ["--questions", "non_existent_survey_questions.csv"]
    test "outputs an error message", %{output: output} do
      assert output =~ @error_message
    end
  end

  describe "Questions file with unknown question types" do
    @error_message Utilities.error_string(
      """
      Could not generate report. \
      Responses file contained unknown question type of: unknown\
      """
    )

    @tag argv: [
           "--questions",
           "test/fixtures/questions/unknown_question_types.csv"
         ]
    test "outputs an error message", %{output: output} do
      assert output =~ @error_message
    end
  end
end
