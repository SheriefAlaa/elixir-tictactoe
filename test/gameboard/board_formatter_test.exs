defmodule GameBoard.BoardFormatterTest do
  use ExUnit.Case
  alias GameBoard.BoardFormatter
  alias PlayerSymbols, as: Symbols

  test "formats an empty board" do
    board = [nil, nil, nil,
             nil, nil, nil,
             nil, nil, nil]
    assert BoardFormatter.format(board) == [[1, 2, 3],
                                            [4, 5, 6],
                                            [7, 8, 9]]
  end

  test "formats a board with moves" do
    board = [nil, Symbols.x, nil,
             nil, nil, Symbols.o,
             nil, nil, nil]
    assert BoardFormatter.format(board) == [[1, Symbols.x, 3],
                                            [4, 5, Symbols.o],
                                            [7, 8, 9]]
  end
end
