defmodule StrScanTest do
  use ExUnit.Case
  doctest StrScan

  test "new/1 sets the string value of the struct" do
    expected = "This is an example string"

    actual = StrScan.new(expected)

    assert actual.string == expected
    assert actual.pointer == 0
  end

  test "eof/1 returns false if pointer is not at end of string" do
    struct = StrScan.new("This is an example string")
    expected = false

    actual = StrScan.eof?(struct)

    assert actual == expected
  end

  test "eof/1 returns true if pointer is at end of string" do
    struct = StrScan.new("")
    expected = true

    actual = StrScan.eof?(struct)

    assert actual == expected
  end

  test "scan/2 receives a regex and returns first match and new scan struct" do
    struct = StrScan.new("abc def")
    expected = ["abc", %StrScan{string: " def", pointer: 3, eof: 7}]

    actual = StrScan.scan(struct, ~r{\w+})

    assert actual == expected
  end

  test "scan/2 returns nil when the regex doesn't match the beginning of the string" do
    struct = StrScan.new("abc def")
    expected = [nil, %StrScan{string: "abc def", pointer: 0, eof: 7}]

    actual = StrScan.scan(struct, ~r{\s+})

    assert actual == expected
  end

  test "scan/2 remembers its place in the string" do
    struct = StrScan.new("abc def")

    first_run_expected = ["abc", %StrScan{string: " def", pointer: 3, eof: 7}]
    first_run_actual = StrScan.scan(struct, ~r{\w+})
    assert first_run_actual == first_run_expected

    second_run_expected = [" ", %StrScan{string: "def", pointer: 4, eof: 7}]
    second_run_actual = StrScan.scan(List.last(first_run_actual), ~r{\s+})
    assert second_run_actual == second_run_expected

    third_run_expected = ["def", %StrScan{string: "", pointer: 7, eof: 7}]
    third_run_actual = StrScan.scan(List.last(second_run_actual), ~r{\w+})
    assert third_run_actual == third_run_expected
  end

  test "eof/1 returns false until scan process completed" do
    struct = StrScan.new("abc def")

    first_run_expected = false
    first_run = StrScan.scan(struct, ~r{\w+})
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

  test "does not consume the original string" do
    string = "abc def"

    struct = StrScan.new(string)
    StrScan.scan(struct, ~r{\w+})
    actual = string

    assert actual == "abc def"
  end
end
