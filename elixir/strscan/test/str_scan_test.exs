defmodule StrScanTest do
  use ExUnit.Case
  doctest StrScan

  test "eof/1 returns false if pointer is not at end of string" do
    string = "This is an example string"
    expected = false

    actual = StrScan.eof?(string)

    assert actual == expected
  end

  test "eof/1 returns true if pointer is at end of string" do
    string = ""
    expected = true

    actual = StrScan.eof?(string)

    assert actual == expected
  end

  test "eof/1 returns false until scan process completed" do
    string = "abc def"

    first_run_expected = false
    first_run = StrScan.scan(string, ~r{\w+})
    first_run_actual = StrScan.eof?(List.last(first_run))
    assert first_run_actual == first_run_expected

    second_run_expected = false
    second_run = StrScan.scan(List.last(first_run), ~r{\s+})
    second_run_actual = StrScan.eof?(List.last(second_run))
    assert second_run_actual == second_run_expected

    third_run_expected = true
    third_run = StrScan.scan(List.last(second_run), ~r{\w+})
    third_run_actual = StrScan.eof?(List.last(third_run))
    assert third_run_actual == third_run_expected
  end

  test "scan/2 receives a regex and returns first match and new scan struct" do
    string = "abc def"
    expected = ["abc", " def"]

    actual = StrScan.scan(string, ~r{\w+})

    assert actual == expected
  end

  test "scan/2 returns nil when the regex doesn't match the beginning of the string" do
    string = "abc def"
    expected = [nil, "abc def"]

    actual = StrScan.scan(string, ~r{\s+})

    assert actual == expected
  end

  test "scan/2 remembers its place in the string" do
    string = "abc def"

    first_run_expected = ["abc", " def"]
    first_run_actual = StrScan.scan(string, ~r{\w+})
    assert first_run_actual == first_run_expected

    second_run_expected = [" ", "def"]
    second_run_actual = StrScan.scan(List.last(first_run_actual), ~r{\s+})
    assert second_run_actual == second_run_expected

    third_run_expected = ["def", ""]
    third_run_actual = StrScan.scan(List.last(second_run_actual), ~r{\w+})
    assert third_run_actual == third_run_expected
  end

  test "scan/2 does not consume the original string" do
    string = "abc def"

    StrScan.scan(string, ~r{\w+})
    actual = string

    assert actual == "abc def"
  end
end
