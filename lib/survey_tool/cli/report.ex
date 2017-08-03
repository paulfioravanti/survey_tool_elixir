defmodule SurveyTool.CLI.Report do
  @moduledoc false

  alias TableRex.Table
  alias SurveyTool.Survey
  alias SurveyTool.CLI.Console
  alias SurveyTool.CLI.Report.{
    Header,
    ParticipationCount,
    ParticipationPercentage,
    QuestionAndAnswers,
    ThemeTitle,
    Title
  }

  @render_style [horizontal_style: :off, vertical_style: :off]

  def output(survey) do
    Console.output("")
    Table.new()
    |> Header.row()
    |> ParticipationPercentage.row(survey)
    |> ParticipationCount.row(survey)
    |> survey_body(survey)
  end

  defp survey_body(table, %Survey{participant_count: count}) when count < 1 do
    table
    |> render()
  end
  defp survey_body(table, %Survey{questions: questions}) do
    table
    |> Title.row()
    |> add_content(questions)
    |> render()
  end

  defp add_content(table, questions) do
    questions =
      questions
      |> Enum.group_by(fn(question) -> question.theme end)

    Enum.reduce(questions, table, fn({theme, questions}, table) ->
      table
      |> ThemeTitle.row(theme)
      |> QuestionAndAnswers.row(questions)
     end)
  end

  defp render(table) do
    table
    |> Table.render!(@render_style)
    |> Console.output()
  end
end