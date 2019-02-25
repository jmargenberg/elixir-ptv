defmodule PTV.Call do
  @moduledoc """
  Struct representing a call to the PTV API.

  Strictly conforms to spec at https://timetableapi.ptv.vic.gov.au/swagger/ui/index.

  * `:base_url`: the base url of the API server, defaults to `"http://timetableapi.ptv.vic.gov.au"`.
  * `:api_version`: the version of the api being called, defaults to `"v3"`.
  * `:api_name`: the name of the resource being called, .e.g. `"stops"`.
  * `:search_string`: id or further path of the resource being called, .e.g `"10/route_type/3"`
  * `:params`: map of query paramters, .e.g `%{stop_amenities: true}`
  """

  @ptv_base_url "http://timetableapi.ptv.vic.gov.au"
  @ptv_api_vesion "v3"

  defstruct base_url: @ptv_base_url,
            api_version: @ptv_api_vesion,
            api_name: "",
            search_string: "",
            params: %{}
end
