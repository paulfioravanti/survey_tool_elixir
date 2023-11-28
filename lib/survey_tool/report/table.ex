defmodule SurveyTool.Report.Table do
  @moduledoc """
  Module representing a survey report table.
  """

  alias SurveyTool.{CLI, SurveyParser}

  alias SurveyTool.Report.{
    Header,
    ParticipationCount,
    ParticipationPercentage,
    QuestionAndAnswers,
    ThemeTitle,
    Title
  }

  alias TableRex.Table

  @typep survey() :: SurveyParser.survey()

  @render_style [horizontal_style: :off, vertical_style: :off]

  @doc """
  Outputs the report content to the console.

  ## Parameters

    - `survey`: The survey whose contents are to be output to the console.
  """
  @spec render(survey()) :: :ok
  def render(survey) do
    CLI.output("")

    Table.new()
    |> Header.row()
    |> ParticipationPercentage.row(survey)
    |> ParticipationCount.row(survey)
    |> survey_body(survey)
    |> render_table()
  end

  defp survey_body(table, %_survey{participant_count: count}) when count < 1 do
    table
  end

  defp survey_body(table, %_survey{questions: questions}) do
    table
    |> Title.row()
    |> add_content(questions)
  end

  defp add_content(table, questions) do
    questions
    |> Enum.group_by(& &1.theme)
    |> Enum.reduce(table, &to_responses_row/2)
  end

  defp to_responses_row({theme, questions}, table) do
    table
    |> ThemeTitle.row(theme)
    |> QuestionAndAnswers.row(questions)
  end

  defp render_table(table) do
    table
    |> Table.render!(@render_style)
    |> CLI.output()
  end
end
