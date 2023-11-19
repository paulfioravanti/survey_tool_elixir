defmodule SuccessfulReportGenerationTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @report_output File.read!("test/fixtures/output/valid_survey_output.txt")

  setup(%{argv: argv}) do
    output = capture_io(fn -> SurveyTool.start(argv) end)
    {:ok, [output: output]}
  end

  describe "Generating a report, only specifying a questions file" do
    @tag argv: ["-q", "test/fixtures/valid_survey_questions.csv"]
    test "when using short option -q, responses file location is assumed, " <>
           "and a report is outputted to stdout",
         %{output: output} do
      assert output == @report_output
    end

    @tag argv: ["--questions", "test/fixtures/valid_survey_questions.csv"]
    test "when using long option --questions, responses file location is " <>
           "assumed, and a report is outputted to stdout",
         %{output: output} do
      assert output == @report_output
    end
  end

  describe "Generating a report, specifying questions and responses file" do
    @tag argv: [
           "-q",
           "test/fixtures/valid_survey_questions.csv",
           "-r",
           "test/fixtures/valid_survey_responses.csv"
         ]
    test "when using short options for questions and responses files, " <>
           "a report is outputted to stdout",
         %{output: output} do
      assert output == @report_output
    end

    @tag argv: [
           "--questions",
           "test/fixtures/valid_survey_questions.csv",
           "--responses",
           "test/fixtures/valid_survey_responses.csv"
         ]
    test "when using long options for questions and responses files, " <>
           "a report is outputted to stdout",
         %{output: output} do
      assert output == @report_output
    end
  end
end
