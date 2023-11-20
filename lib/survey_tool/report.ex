defmodule SurveyTool.Report do
  @moduledoc """
  Module representing a survey report.
  """

  alias SurveyTool.CLI.Console

  alias SurveyTool.Report.{
    Header,
    ParticipationCount,
    ParticipationPercentage,
    QuestionAndAnswers,
    ThemeTitle,
    Title
  }

  alias SurveyTool.SurveyParser.Survey
  alias TableRex.Table

  @render_style [horizontal_style: :off, vertical_style: :off]

  @doc """
  Outputs the report content to the console.

  ## Parameters

    - `survey`: The survey whose contents are to be output to the console.
  """
  @spec render_report(Survey.t()) :: :ok
  def render_report(survey) do
    Console.output("")

    Table.new()
    |> Header.row()
    |> ParticipationPercentage.row(survey)
    |> ParticipationCount.row(survey)
    |> survey_body(survey)
    |> render()
  end

  defp survey_body(table, %Survey{participant_count: count}) when count < 1 do
    table
  end

  defp survey_body(table, %Survey{questions: questions}) do
    table
    |> Title.row()
    |> add_content(questions)
  end

  defp add_content(table, questions) do
    questions =
      questions
      |> Enum.group_by(fn question -> question.theme end)

    Enum.reduce(questions, table, fn {theme, questions}, table ->
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
