defmodule SurveyTool.SingleSelect do
  alias __MODULE__, as: SingleSelect

  defstruct answers: %{}, text: nil, theme: nil

  def add_answer(question = %SingleSelect{answers: answers}, answer) do
    answers =
      case Map.has_key?(answers, answer) do
        true ->
          %{answers | answer => answers[answer] + 1}
        false ->
          Map.put(answers, answer, 1)
          # %{answers | answer => 1}
      end
    %SingleSelect{question | answers: answers}
  end
end
