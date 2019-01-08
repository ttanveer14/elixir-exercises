defmodule GetfileTest do
  use ExUnit.Case
  #use ExUnit.CaptureIO

  alias Weather.Getfile

  test "opens file successfully" do
    body = Getfile.readxml("https://w1.weather.gov/xml/current_obs/KMDW.xml")
    assert body != {}
  end
end
