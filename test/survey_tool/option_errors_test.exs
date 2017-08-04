defmodule OptionsErrorsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @help_output "#{File.read!("lib/survey_tool/cli/help.txt")}\n"

  setup(%{argv: argv}) do
    output = capture_io(fn -> SurveyTool.main(argv) end)
    {:ok, [output: output]}
  end

  describe "No options provided" do
    @error_message "questions option must be provided."
                   |> Utilities.error_string()
    setup do
      expected_output = "#{@error_message}#{@help_output}"
      {:ok, [expected: expected_output]}
    end

    @tag argv: []
    test "an error message and the help message is output to stdout",
         %{output: output, expected: expected} do
      assert output == expected
    end
  end

  describe "Questions option provided without filepath" do
    @error_message "Path must be specified for questions option."
                   |> Utilities.error_string()

    setup do
      expected_output = "#{@error_message}#{@help_output}"
      {:ok, [expected: expected_output]}
    end

    @tag argv: ["--questions"]
    test "using the long questions option, an error message and " <>
         "the help message is output to stdout",
         %{output: output, expected: expected} do
      assert output == expected
    end

    @tag argv: ["-q"]
    test "using the short questions option, an error message and " <>
         "the help message is output to stdout",
         %{output: output, expected: expected} do
      assert output == expected
    end
  end

  describe "Responses option provided without filepath" do
    @error_message "Path must be specified for responses option."
                   |> Utilities.error_string()

    setup do
      expected_output = "#{@error_message}#{@help_output}"
      {:ok, [expected: expected_output]}
    end

    @tag argv: [
      "--questions",
      "test/fixtures/valid_survey_questions.csv",
      "--responses",
    ]
    test "using the long responses option, an error message and " <>
         "the help message is output to stdout",
         %{output: output, expected: expected} do
      assert output == expected
    end

    @tag argv: [
      "-q",
      "test/fixtures/valid_survey_questions.csv",
      "-r",
    ]
    test "using the short responses option, an error message and " <>
         "the help message is output to stdout",
         %{output: output, expected: expected} do
      assert output == expected
    end
  end

  describe "Only responses option provided" do
    @error_message "questions option must be provided."
                   |> Utilities.error_string()

    setup do
      expected_output = "#{@error_message}#{@help_output}"
      {:ok, [expected: expected_output]}
    end

    @tag argv: [
      "--responses",
      "test/fixtures/valid_survey_responses.csv",
    ]
    test "an error message and the help message is output to stdout",
         %{output: output, expected: expected} do
      assert output == expected
    end
  end
end
