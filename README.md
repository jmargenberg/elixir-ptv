[![Hex.pm](https://img.shields.io/hexpm/v/ptv.svg)](https://hex.pm/packages/ptv) [![Build Status](https://travis-ci.org/jmargenberg/ptv.svg?branch=master)](https://travis-ci.org/jmargenberg/ptv) [![Coverage Status](https://coveralls.io/repos/github/jmargenberg/ptv/badge.svg?branch=master)](https://coveralls.io/github/jmargenberg/ptv?branch=master)

# Elixir PTV

An API adaptor for version 3 of the PTV Timetable API.

This is a thin API adaptor that performs standard authentication, decoding and error handling but does not implement functions for each of the API's REST methods.

## Usage

You can register for a devid and API key from PTV by following the instructions [here](https://www.ptv.vic.gov.au/footer/data-and-reporting/datasets/ptv-timetable-api/).

## Documentation

Documentation can be found at [hexdocs](https://hexdocs.pm/ptv).

## Installation

This package can be installed by adding `ptv` to your list of dependencies in `mix.exs`

```elixir
def deps do
  [
    {:ptv, "~> 0.1.0"}
  ]
end
```
