defmodule PTV do
  @moduledoc """
  API adaptor for the PTV Timetable API
  """

  alias PTV.Call

  def signed_call_url(
        %{
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

  def execute_call(call, devid, api_key) do
    case call |> signed_call_url(devid, api_key) |> HTTPoison.get() do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        decode_call_response(status_code, body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, {:connection_failed, reason}}
    end
  end

  defp decode_call_response(status_code, body) do
    case body |> Poison.decode() do
      {:ok, decoded_body} ->
        case status_code do
          200 ->
            {:ok, decoded_body}

          400 ->
            {:error, {:invalid_request, decoded_body["message"]}}

          403 ->
            {:error, {:access_denied, decoded_body["message"]}}
        end

      {:error, reason} ->
        {:error, {:decode_failed, reason}}
    end
  end
end
