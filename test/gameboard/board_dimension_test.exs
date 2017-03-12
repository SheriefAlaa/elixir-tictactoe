defmodule GameBoard.BoardDimensionTest do
  use ExUnit.Case
  alias GameBoard.BoardDimension, as: BoardDimension

  test "formats dimensions for display" do
    assert BoardDimension.for_display == "3 or 4"
  end

  test "recognises 3 as a valid dimension" do
    assert BoardDimension.valid_dimension?(3) == true
  end

  test "recognises 4 as a valid dimension" do
    assert BoardDimension.valid_dimension?(4) == true
  end

  test "recognises an invalid dimension" do
    assert BoardDimension.valid_dimension?(7) == false
  end
end
