defmodule SurveyTool.CLI.Report do
  @moduledoc false

  alias TableRex.Table
  alias SurveyTool.Survey

  def output(survey) do
    IO.puts("")
    table =
      Table.new()
      |> Table.add_row(["** SURVEY REPORT **"])
      |> Table.add_row(["==================="])
      |> Table.add_row([""])
      |> Table.add_row(["Participation Percentage:\t#{formatted_participation_percentage(survey)}%"])
      |> Table.add_row(["Participation Count:\t\t#{formatted_participation_count(survey)} Submitted"])
    case survey.participant_count > 0 do
      true ->
        table
        |> Table.add_row([""])
        |> Table.add_row(["Questions and Answers by Theme (submitted surveys only)"])
        |> Table.add_row(["======================================================="])
        |> Table.add_row([""])
        |> Table.add_row(["--------"])
        |> Table.add_row(["The Work"])
        |> Table.add_row(["--------"])
        |> Table.add_row([""])
        |> Table.add_row(["Q: I like the kind of work I do."])
        |> Table.add_row(["Average Score: 4.6 (5 responses submitted)"])
        |> Table.add_row([""])
        |> Table.add_row(["Q: Manager"])
        |> Table.add_row(["Bob (1), Jane (1), John (1), Mary (1), Sally (1)"])
        |> Table.add_row([""])
        |> Table.add_row(["---------"])
        |> Table.add_row(["The Place"])
        |> Table.add_row(["---------"])
        |> Table.add_row([""])
        |> Table.add_row(["Q: I feel empowered to get the work done for which I am responsible."])
        |> Table.add_row(["Average Score: 3.6 (5 responses submitted)"])
        |> Table.render!(horizontal_style: :off, vertical_style: :off)
        |> IO.puts()
      false ->
        table
        |> Table.render!(horizontal_style: :off, vertical_style: :off)
        |> IO.puts()
    end
  end

  defp formatted_participation_percentage(survey) do
    survey
    |> Survey.participation_percentage()
    |> Decimal.mult(Decimal.new(100))
    |> Decimal.round(2)
    |> Decimal.to_string()
  end

  defp formatted_participation_count(survey) do
    "#{survey.participant_count}/#{survey.response_count}"
  end
end
