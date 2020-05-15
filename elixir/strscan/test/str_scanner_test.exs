defmodule StrScannerTest do
  use ExUnit.Case
  doctest StrScan

  test "eof?/1 returns false if string is not empty" do
    string = "abc def"
    expected = false

    actual = StrScan.eof?(string)

    assert expected == actual
  end

  test "eof?/1 returns true if string is empty" do
    string = ""
    expected = true

    actual = StrScan.eof?(string)

    assert expected == actual
  end

  test "scan/2 returns match and remainder regex" do
    string = "abc"
    regex = ~r{abc}
    expected = ["abc", ""]

    actual = StrScan.scan(string, regex)

    assert expected == actual
  end

  test "scan/2 returns match and remainder regex if string starts with match" do
    string = "abc def"
    regex = ~r{abc}
    expected = ["abc", " def"]

    actual = StrScan.scan(string, regex)

    assert expected == actual
  end

  test "scan/2 returns nil and string if string does not start with match" do
    string = "abc def"
    regex = ~r{\s+}
    expected = [nil, "abc def"]

    actual = StrScan.scan(string, regex)

    assert expected == actual
  end
end
