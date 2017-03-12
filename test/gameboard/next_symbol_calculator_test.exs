defmodule Board.NextSymbolCalculatorTest do
  use ExUnit.Case
  alias GameBoard.Board
  alias GameBoard.NextSymbolCalculator
  alias PlayerSymbols, as: Symbols

  test "generates symbol for next move on an empty board" do
    assert NextSymbolCalculator.next_symbol(Board.create) == Symbols.x
  end

  test "provides symbol X for next move" do
    board = [Symbols.x, Symbols.o, nil, nil, nil, nil, nil, nil, nil]
    assert NextSymbolCalculator.next_symbol(board) == Symbols.x
  end

  test "provides symbol O for next move" do
    board = [Symbols.x, nil, nil, nil, nil, nil, nil, nil, nil]
    assert NextSymbolCalculator.next_symbol(board) == Symbols.o
  end
end
