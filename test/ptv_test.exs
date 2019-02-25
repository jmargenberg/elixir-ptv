defmodule PTVTest do
  use ExUnit.Case

  alias Plug.Conn
  alias PTV.Call

  describe "signed call url " do
    test "correct" do
      assert "http://timetableapi.ptv.vic.gov.au/v3/stops/10/route_type/3?devid=1234567&stop_amenities=true&signature=DA56D25CF40D147F2A4695201DF60124AC7DE400" =
               PTV.signed_call_url(
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

  describe "execute call" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "decodes successful response properly", %{bypass: bypass} do
      response = %{"stops" => [1, 2, 3], "status" => %{"version" => "3.0", "health" => 1}}

      Bypass.expect(bypass, fn conn ->
        Conn.resp(conn, 200, Poison.encode!(response))
      end)

      assert {:ok, ^response} =
               PTV.execute_call(
                 %Call{
                   base_url: "localhost:#{bypass.port}",
                   api_name: "stops",
                   search_string: "10/route_type/3"
                 },
                 "123456",
                 "12345678901234567890"
               )
    end

    test "returns :invalid_requests for 400 response", %{bypass: bypass} do
      response = %{
        "message" => "stop 10 doesn't exist",
        "status" => %{"version" => "3.0", "health" => 1}
      }

      Bypass.expect(bypass, fn conn ->
        Conn.resp(conn, 400, Poison.encode!(response))
      end)

      assert {:error, {:invalid_request, "stop 10 doesn't exist"}} =
               PTV.execute_call(
                 %Call{
                   base_url: "localhost:#{bypass.port}",
                   api_name: "stops",
                   search_string: "10/route_type/3"
                 },
                 "123456",
                 "12345678901234567890"
               )
    end

    test "returns :access_denied for 403 response", %{bypass: bypass} do
      response = %{
        "message" => "devid doesn't exist",
        "status" => %{"version" => "3.0", "health" => 1}
      }

      Bypass.expect(bypass, fn conn ->
        Conn.resp(conn, 403, Poison.encode!(response))
      end)

      assert {:error, {:access_denied, "devid doesn't exist"}} =
               PTV.execute_call(
                 %Call{
                   base_url: "localhost:#{bypass.port}",
                   api_name: "stops",
                   search_string: "10/route_type/3"
                 },
                 "123456",
                 "12345678901234567890"
               )
    end

    test "returns :decode_failed error if invalid json received", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Conn.resp(conn, 200, "{nonsense: json")
      end)

      assert {:error, {:decode_failed, _}} =
               PTV.execute_call(
                 %Call{
                   base_url: "localhost:#{bypass.port}",
                   api_name: "stops",
                   search_string: "10/route_type/3"
                 },
                 "123456",
                 "12345678901234567890"
               )
    end

    test "returns :connection_failed error for a http error", %{bypass: bypass} do
      Bypass.down(bypass)

      assert {:error, {:connection_failed, _}} =
               PTV.execute_call(
                 %Call{
                   base_url: "localhost:#{bypass.port}",
                   api_name: "stops",
                   search_string: "10/route_type/3"
                 },
                 "123456",
                 "12345678901234567890"
               )
    end
  end
end
