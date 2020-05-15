defmodule StrScan do

  def eof?(string) do
    string == ""
  end

  def scan(string, regex) do
    results = Regex.scan(regex, string)

    result = parse_results(results)

    get_scan_result(string, result)
  end

  defp get_scan_result(string, result) do
    starts_with = String.starts_with?(string, result)

    if starts_with do
      get_new_string(string, result)
    else
      [nil, string]
    end
  end

  defp parse_results(results) do
    if results == [],
      do: nil,
      else: List.first(List.first(results))
  end

  defp get_new_string(string, match) do
    length = String.length(match)
    range = length..-1
    newString = String.slice(string, range)
    [match, newString]
  end

end
