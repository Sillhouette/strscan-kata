defmodule AcceptanceTest do
  use ExUnit.Case
  doctest StrScan

  test "acceptance test" do
    string = "This is an example string"
    pattern_1 = ~r{\w+}
    pattern_2 = ~r{\s+}
    assert StrScan.eof?(string) == false

    first_run = StrScan.scan(string, pattern_1)
    assert List.first(first_run) == "This"
    second_run = StrScan.scan(List.last(first_run), pattern_1)
    assert List.first(second_run) == nil
    third_run = StrScan.scan(List.last(second_run), pattern_2)
    assert List.first(third_run) == " "
    fourth_run = StrScan.scan(List.last(third_run), pattern_2)
    assert List.first(fourth_run) == nil
    assert StrScan.eof?(List.last(fourth_run)) == false

    fifth_run = StrScan.scan(List.last(fourth_run), pattern_1)
    assert List.first(fifth_run) == "is"
    sixth_run = StrScan.scan(List.last(fifth_run), pattern_2)
    assert List.first(sixth_run) == " "
    seventh_run = StrScan.scan(List.last(sixth_run), pattern_1)
    assert List.first(seventh_run) == "an"
    eighth_run = StrScan.scan(List.last(seventh_run), pattern_2)
    assert List.first(eighth_run) == " "
    ninth_run = StrScan.scan(List.last(eighth_run), pattern_1)
    assert List.first(ninth_run) == "example"
    tenth_run = StrScan.scan(List.last(ninth_run), pattern_2)
    assert List.first(tenth_run) == " "
    eleventh_run = StrScan.scan(List.last(tenth_run), pattern_1)
    assert List.first(eleventh_run) == "string"
    assert StrScan.eof?(List.last(eleventh_run)) == true

    twelfth_run = StrScan.scan(List.last(eleventh_run), pattern_1)
    assert List.first(twelfth_run) == nil
    thirteenth_run = StrScan.scan(List.last(twelfth_run), pattern_2)
    assert List.first(thirteenth_run) == nil
  end

end
