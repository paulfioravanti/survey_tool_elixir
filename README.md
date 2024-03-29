[![Build Status][Build Status image]][Build Status url]

# CSV Survey Tool Developer Coding Test

An [Elixir][] CLI application that parses survey data from CSV files, and
displays the results.

![Screenshot][screenshot url]

I also wrote a version of this app in [Ruby][], which can be found
[here][survey-tool-ruby]. There is also a sibling repo to this containing
Culture Amp's front end coding test, which I wrote in [Elm][]. It can be found
[here][survey-tool-elm].

My review of the coding tests can be found in the following blog post:

- _[Coding Test Review: Culture Amp][]_

## Setup

```console
git clone https://github.com/paulfioravanti/survey_tool_elixir.git
cd survey_tool_elixir
mix deps.get
```

## Usage

Run the application with the following command:

```console
bin/survey-tool -q questions.csv [-r responses.csv]
```

If the survey responses CSV file is _not_ specified, it will attempt to be
inferred.  For example, if the questions CSV file is named
`path/to/questions.csv`, then the application will attempt to use
`path/to/questions-responses.csv` for the responses file.

Other options can be seen by running the help command:

```console
bin/survey-tool -h
```

## Development

### Dependencies

- Elixir 1.15.7 ([asdf-elixir pre-compiled version][]: 1.15.7-otp-26)
- Erlang 26.1.2

### Environment

Heavy use of [`mix test.watch`][] was made during development to ensure code
quality, so I highly recommend having the following commands running in other
terminal windows:

```console
mix test.watch
iex -S mix
```

If you are a [Tmuxinator][] user, you can find my config for this project
[here][tmuxinator-config].

## Tests

[ExUnit][] was used for the tests, which can be run with the following command:

```console
mix test
```

## Coverage Report

View the [ExCoveralls][] test coverage report:

```console
open cover/excoveralls.html
```

## Application Documentation

Generate the [ExDoc][] documentation (if not already done by running the tests)
and open them:

```console
mix docs
open doc/index.html
```

[asdf-elixir pre-compiled version]: https://github.com/asdf-vm/asdf-elixir#elixir-precompiled-versions
[Build Status image]: https://github.com/paulfioravanti/survey_tool_elixir/actions/workflows/ci.yml/badge.svg
[Build Status url]: https://github.com/paulfioravanti/survey_tool_elixir/actions/workflows/ci.yml
[Coding Test Review: Culture Amp]: https://www.paulfioravanti.com/blog/coding-test-review-culture-amp/
[Elixir]: https://github.com/elixir-lang/elixir
[Elm]: https://elm-lang.org/
[ExCoveralls]: https://github.com/parroty/excoveralls
[ExDoc]: https://github.com/elixir-lang/ex_doc
[ExUnit]: https://hexdocs.pm/ex_unit/ExUnit.html
[`mix test.watch`]: https://github.com/lpil/mix-test.watch
[Ruby]: https://github.com/ruby/ruby
[screenshot url]: ./elixir-screenshot.jpg
[survey-tool-elm]: https://github.com/paulfioravanti/survey_tool_elm
[survey-tool-ruby]: https://github.com/paulfioravanti/survey_tool_ruby
[Tmuxinator]: https://github.com/tmuxinator/tmuxinator
[tmuxinator-config]: https://github.com/paulfioravanti/dotfiles/blob/master/tmuxinator/survey_tool_elixir.yml

---

# Requirements

# Culture Amp's Developer Coding Test

Your task is to build a CLI application to parse and display survey data from CSV files, and display the results.

## Data Format

### Survey Data
Included in the folder example-data are three sample data files defining surveys:
* survey-1.csv
* survey-2.csv
* survey-3.csv

Each row represents a question in that survey with headers defining what question data is in each column.

### Response Data
And three sample files containing responses to the corresponding survey:
* survey-1-responses.csv
* survey-2-responses.csv
* survey-3-responses.csv

Response columns are always in the following order:
* Email
* Employee Id
* Submitted At Timestamp (if there is no submitted at timestamp, you can assume the user did not submit a survey)
* Each column from the fourth onwards are responses to survey questions.
* Answers to Rating Questions are always an integer between (and including) 1 and 5.
* Blank answers represent not answered.
* Answers to Single Select Questions can be any string.

## The Application

Your coding challenge is to build an application that allows the user to specify a survey file and a file for it's results. It should read them in and present a summary of the survey results. A command line application that takes a data file as input is sufficient.

The output should include:

1. The participation percentage and total participant counts of the survey.
- Any response with a 'submitted_at' date has submitted and is said to have participated in the survey.
2. The average for each rating question
- Results from unsubmitted surveys should not be considered in the output.

## Other information

Please include a Readme with any additional information you would like to include. You may wish to use it to explain any design decisions.

Despite this being a small command line app, please approach this as you would a production problem using whatever approach to coding and testing you feel appropriate. Successful candidates will be asked to extend their implementation in a pair programming session as a component of the interview, so consider extensibility.
