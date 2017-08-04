defmodule ResponsesFileErrorsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "Responses file doesn't match questions file" do
    @error_message """
    Could not generate report.\s
    Check if your responses file fits your questions file.
    """
    |> String.replace("\n", "")
    |> Utilities.error_string()

    setup(%{argv: argv}) do
      output = capture_io(fn -> SurveyTool.main(argv) end)
      {:ok, [output: output]}
    end

    @tag argv: [
      "--questions",
      "test/fixtures/questions/only_rating_questions.csv",
      "--responses",
      "test/fixtures/responses/submitted_responses_of_different_valid_types.csv"
    ]
    test "outputs an error message", %{output: output} do
      assert output =~ @error_message
    end
  end
end
