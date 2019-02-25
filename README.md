# Elixir PTV

An API adaptor for version 3 of the PTV Timetable API.

This is a thin API adaptor that performs standard authentication, decoding and error handling but does not implement functions for each of the API's REST methods.

## Usage
You can register an  devid and API key from PTV by following the instructions [here](https://www.ptv.vic.gov.au/footer/data-and-reporting/datasets/ptv-timetable-api/)

## Documentation
Documentation can be found at [hexdocs](https://hexdocs.pm/ptv)

## Installation

This package can be installed by adding `ptv` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ptv, "~> 0.1.0"}
  ]
end
```
