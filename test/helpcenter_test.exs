defmodule HelpcenterTest do
  use ExUnit.Case
  doctest Helpcenter

  test "greets the world" do
    assert Helpcenter.hello() == :world
  end
end
