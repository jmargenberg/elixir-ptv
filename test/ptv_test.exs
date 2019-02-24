defmodule PTVTest do
  use ExUnit.Case
  doctest PTV

  test "greets the world" do
    assert PTV.hello() == :world
  end
end
