defmodule GetfileTest do
  use ExUnit.Case
  #use ExUnit.CaptureIO

  alias Weather.Getfile, as: GF

  test "opens file successfully" do
    body = GF.readxml("https://w1.weather.gov/xml/current_obs/KMDW.xml")
    assert body != {}
    IO.inspect(body)
  end
end
