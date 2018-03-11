defmodule Utilities do
  # Generates a full error string with an
  # ANSI reset and newline appended to the end.
  def error_string(message) do
    message
    |> error_string(fn chardata -> IO.ANSI.format(chardata, true) end)
    |> Kernel.<>("\n")
  end

  # Generates an error string without an
  # ANSI reset or newline appended to the end.
  def error_fragment(message) do
    message
    |> error_string(fn chardata -> IO.ANSI.format_fragment(chardata, true) end)
  end

  defp error_string(message, ansi_function) do
    [:red, message]
    |> ansi_function.()
    |> List.to_string()
  end
end
