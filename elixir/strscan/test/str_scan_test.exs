defmodule StrScanTest do
  use ExUnit.Case
  doctest StrScan

  test "eof/1 returns false if string is not empty" do
    string = "abc def"
    expected = false

    actual = StrScan.eof?(string)

    assert actual == expected
  end

  test "eof/1 returns true if string is empty" do
    string = ""
    expected = true

    actual = StrScan.eof?(string)

    assert actual == expected
  end

  test "scan/2 returns match" do
    string = "def"
    expected = ["def", ""]

    actual = StrScan.scan(string, ~r{def})

    assert actual == expected
  end

  test "scan/2 returns first match" do
    string = "abc def"
    expected = ["abc", " def"]

    actual = StrScan.scan(string, ~r{\w+})

    assert actual == expected
  end

  test "scan/2 returns nil if string doesnt start with match" do
    string = "abc def"
    expected = [nil, "abc def"]

    actual = StrScan.scan(string, ~r{\s+})

    assert actual == expected
  end
end
