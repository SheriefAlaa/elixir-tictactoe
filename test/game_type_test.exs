defmodule GameTypeTest do
  use ExUnit.Case

  test "human vs human found by id" do
    assert GameType.with_id(1) == "Human vs Human"
  end

  test "human vs computer found by id" do
    assert GameType.with_id(2) == "Human vs Computer"
  end

  test "computer vs human found by id" do
    assert GameType.with_id(3) == "Computer vs Human"
  end

  test "computer vs computer found by id" do
    assert GameType.with_id(4) == "Computer vs Computer"
  end

  test "display for prompt" do
    assert GameType.for_display == "(1) Human vs Human\n(2) Human vs Computer\n(3) Computer vs Human\n(4) Computer vs Computer"
  end
end
