ExUnit.start()

defmodule Utilities do
  # Generates a full error string with an
  # ANSI reset appended to the end.
  def error_string(message) do
    error_string(message, fn(chardata) ->
      IO.ANSI.format(chardata, true)
    end)
  end

  # Generates an error string without an
  # ANSI reset appended to the end.
  def error_fragment(message) do
    error_string(message, fn(chardata) ->
      IO.ANSI.format_fragment(chardata, true)
    end)
  end

  defp error_string(message, ansi_function) do
    [:red, message]
    |> ansi_function.()
    |> List.to_string()
  end
end
