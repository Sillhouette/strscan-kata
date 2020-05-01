defmodule StrScan do
  def eof?(string) do
    string == ""
  end

  def scan(string, regex) do
    scan_results = Regex.scan(regex, string)
    result = getRelevantResult(scan_results)

    if String.starts_with?(string, result),
      do: [result, getNewString(string, result)],
      else: [nil, string]
  end

  defp getRelevantResult(results) do
    if results == [],
      do: nil,
      else: List.first(List.first(results))
  end

  defp getNewString(original, match) do
    length = String.length(match)
    range = length..-1
    String.slice(original, range)
  end
end
