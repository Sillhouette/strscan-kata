defmodule StrScan do
  @moduledoc """
  Documentation for `StrScan`.
  """

  @doc """
  Hello world.

  ## Examples

  """
  def eof?(string) do
    string == ""
  end

  def scan(string, regex) do
    scan_results = Regex.scan(regex, string)

    result = if scan_results == [] do
      nil
    else
      List.first(List.first(scan_results))
    end

    if String.starts_with?(string, result) do
      result_length = String.length(result)
      slice_range = result_length..-1
      new_string = String.slice(string, slice_range)

      [result, new_string]
    else
      [nil, string]
    end
  end
end
