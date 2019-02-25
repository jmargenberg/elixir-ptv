defmodule PTV.CallTest do
  use ExUnit.Case
  doctest PTV.Call

  alias PTV.Call

  describe "call" do
    test "signed url built properly" do
      assert "http://timetableapi.ptv.vic.gov.au/v3/stops/10/route_type/3?devid=1234567&stop_amenities=true&signature=DA56D25CF40D147F2A4695201DF60124AC7DE400" =
               Call.signed_url(
                 %Call{
                   api_name: "stops",
                   search_string: "10/route_type/3",
                   params: %{stop_amenities: true}
                 },
                 "1234567",
                 "12345678901234567890"
               )
    end
  end
end
