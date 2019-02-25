defmodule PTV.Call do
  @moduledoc """
  Basic support for building calls and generating signed urls.

  Strictly conforms to spec at https://timetableapi.ptv.vic.gov.au/swagger/ui/index
  """

  @ptv_base_url "http://timetableapi.ptv.vic.gov.au"
  @ptv_api_vesion "v3"

  defstruct base_url: @ptv_base_url,
            api_version: @ptv_api_vesion,
            api_name: "",
            search_string: "",
            params: %{}

  def signed_url(
        %_call{
          base_url: base_url,
          api_version: api_version,
          api_name: api_name,
          search_string: search_string,
          params: params
        },
        devid,
        api_key
      ) do
    query_params =
      params
      |> Map.put(:devid, devid)

    query_string =
      query_params
      |> Map.keys()
      |> Enum.map(fn key -> "#{key}=#{query_params[key]}" end)
      |> Enum.join("&")

    request_message = "/#{api_version}/#{api_name}/#{search_string}?#{query_string}"

    hmac_digest = :crypto.hmac(:sha, api_key, request_message) |> Base.encode16()

    "#{base_url}#{request_message}&signature=#{hmac_digest}"
  end
end
