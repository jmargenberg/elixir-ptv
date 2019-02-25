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
end
