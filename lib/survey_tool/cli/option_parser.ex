defmodule SurveyTool.CLI.OptionParser do
  @moduledoc false

  alias SurveyTool.CLI.Console

  @aliases [h: :help, q: :questions, r: :responses, v: :version]
  @argument_types [
    help: :boolean,
    questions: :string,
    responses: :string,
    version: :boolean
  ]
  @filetype_regex ~r/(?=[.].+\z)/
  @help File.read!(Path.expand("help.txt", __DIR__))
  @version Mix.Project.config[:version]

  def parse(argv) do
    argv
    |> OptionParser.parse(strict: @argument_types, aliases: @aliases)
    |> process()
  end

  # Specify to print help (valid)
  defp process({[help: true], _args, _invalid}) do
    Console.output(@help)
    throw :halt
  end
  # Specify to print version (valid)
  defp process({[version: true], _args, _invalid}) do
    Console.output(@version)
    throw :halt
  end
  # questions option is specified, but its value is nil (invalid)
  defp process({_parsed, _args, [{"--questions", nil}]}) do
    handle_bad_questions()
  end
  # q alias option is specified, but its value is nil (invalid)
  defp process({_parsed, _args, [{"-q", nil}]}) do
    handle_bad_questions()
  end
  # questions is a valid string and responses is specified,
  # but responses value is nil (invalid)
  defp process({[questions: _questions], _args, [{"--responses", nil}]}) do
    handle_bad_responses()
  end
  # questions is a valid string and r alias is specified,
  # but -r value is nil (invalid)
  defp process({[questions: _questions], _args, [{"-r", nil}]}) do
    handle_bad_responses()
  end
  # questions and responses options specified and are both strings (valid)
  defp process({[questions: questions, responses: responses], _args, _inv}) do
    [questions: questions, responses: responses]
  end
  # questions is a string and no responses string given (valid)
  defp process({[questions: questions], _args, _invalid}) do
    [questions: questions, responses: responses_filepath(questions)]
  end
  # questions option is not specified (invalid)
  defp process({_parsed, _args, _invalid}) do
    Console.output(
      error: "questions option must be provided.",
      info: @help
    )
    throw :halt
  end

  defp responses_filepath(questions_filepath) do
    questions_filepath
    |> String.split(@filetype_regex)
    |> List.insert_at(1, "-responses")
    |> Enum.join()
  end

  defp handle_bad_questions do
    Console.output(
      error: "Path must be specified for questions option.",
      info: @help
    )
    throw :halt
  end

  def handle_bad_responses do
    Console.output(
      error: "Path must be specified for responses option.",
      info: @help
    )
    throw :halt
  end
end
