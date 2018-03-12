defmodule SurveyTool.CLI.OptionParser do
  @moduledoc """
  Parser for command line arguments.
  """

  @aliases [
    h: :help,
    q: :questions,
    r: :responses,
    v: :version
  ]
  @argument_types [
    help: :boolean,
    questions: :string,
    responses: :string,
    version: :boolean
  ]
  @filetype_regex ~r/(?=[.].+\z)/
  @help "help.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
  @version Mix.Project.config()[:version]

  @doc """
  Parses a list of arguments and either returns a set of questions
  and responses for a survey, or outputs a message to the console
  and halts operation.

  ## Parameters

    - `argv`: The list of command line arguments.
  """
  @spec parse([String.t()]) ::
          {:ok, questions: String.t(), responses: String.t()}
          | {:info, String.t()}
          | {:error, error: String.t(), info: String.t()}
  def parse(argv) do
    argv
    |> OptionParser.parse(strict: @argument_types, aliases: @aliases)
    |> process()
  end

  # Specify to print help (valid)
  defp process({[help: true], _args, _invalid}) do
    {:info, @help}
  end

  # Specify to print version (valid)
  defp process({[version: true], _args, _invalid}) do
    {:info, @version}
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
    {:ok, questions: questions, responses: responses}
  end

  # questions is a string and no responses string given (valid)
  defp process({[questions: questions], _args, _invalid}) do
    {:ok, questions: questions, responses: responses_filepath(questions)}
  end

  # questions option is not specified (invalid)
  defp process({_parsed, _args, _invalid}) do
    {:error, error: "questions option must be provided.", info: @help}
  end

  defp responses_filepath(questions_filepath) do
    questions_filepath
    |> String.split(@filetype_regex)
    |> List.insert_at(1, "-responses")
    |> Enum.join()
  end

  defp handle_bad_questions do
    {:error, error: "Path must be specified for questions option.", info: @help}
  end

  defp handle_bad_responses do
    {:error, error: "Path must be specified for responses option.", info: @help}
  end
end
