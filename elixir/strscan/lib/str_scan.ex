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

    if String.starts_with?(scanner.string, result) do
      result_length = String.length(result)
      slice_range = result_length..-1
      new_string = String.slice(scanner.string, slice_range)
      new_pointer = scanner.pointer + result_length

      [result, %StrScan{string: new_string, pointer: new_pointer, eof: scanner.eof}]
    else
      [nil, scanner]
    end
  end
end
