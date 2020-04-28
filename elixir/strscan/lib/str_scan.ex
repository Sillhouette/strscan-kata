defmodule StrScan do
  @moduledoc """
  Documentation for `StrScan`.
  """

  @doc """
  Hello world.

  ## Examples

  """
  defstruct [:string, pointer: 0, eof: 0]

  def new(str) do
    %StrScan{string: str, eof: String.length(str)}
  end

  def eof?(scanner) do
    scanner.pointer === scanner.eof
  end

  def scan(scanner, regex) do
    scan_results = Regex.scan(regex, scanner.string)

    result = List.first(List.first(scan_results))
    result_length = String.length(result)

    new_string = String.slice(scanner.string, result_length..-1)
    if String.starts_with?(scanner.string, result) do
      [result, %StrScan{string: new_string, pointer: scanner.pointer + result_length, eof: scanner.eof}]
    else
      [nil, scanner]
    end
  end
end
