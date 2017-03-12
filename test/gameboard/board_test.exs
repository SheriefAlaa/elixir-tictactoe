defmodule Game.BoardTest do
  use ExUnit.Case
  alias GameBoard.Board
  alias PlayerSymbols, as: Symbols

  test "4x4 board is initialised" do
    assert Board.create(4) == [nil, nil, nil, nil,
                               nil, nil, nil, nil,
                               nil, nil, nil, nil,
                               nil, nil, nil, nil]
  end

  test "3x3 board is initialised" do
    assert Board.create(3) == [nil, nil, nil,
                               nil, nil, nil,
                               nil, nil, nil]
  end

  test "empty board is updated with a player symbol" do
    assert Board.create
           |> Board.update(1, Symbols.x) == [nil, Symbols.x, nil,
                                             nil, nil, nil,
                                             nil, nil, nil]
  end

  test "has symbol at given index" do
    assert [nil, Symbols.x, nil,
            nil, nil, nil,
            nil, nil, nil]
           |> Board.symbol_at(1) == Symbols.x
  end

  test "has free spaces when created" do
    assert Board.create
           |> Board.free_spaces? == true
  end

  test "has no free spaces when full" do
    assert full_board_3x3
           |> Board.free_spaces? == false
  end

  test "identifies a cell is unoccupied" do
    assert Board.free_space_at?(0, Board.create) == true
  end

  test "identifies a cell is occupied" do
    assert Board.free_space_at?(0, full_board_3x3) == false
  end

  test "knows all spaces are free on an empty board" do
    assert Board.create
           |> Board.indicies_of_free_spaces == [0, 1, 2,
                                                3, 4, 5,
                                                6, 7, 8]
  end

  test "knows free spaces on a partially occupied board" do
    assert [nil, Symbols.x, nil,
            Symbols.o, nil, nil,
            Symbols.o, Symbols.o, Symbols.o]
           |> Board.indicies_of_free_spaces == [0, 2, 4, 5]
  end

  test "has no free indicies when full" do
    assert full_board_3x3
           |> Board.indicies_of_free_spaces == []
  end

  test "has no winning line if empty" do
    assert Board.create
           |> Board.winning_line? == false
  end

  test "(3x3) has a win in the top row" do
    winning_board = [Symbols.x, Symbols.x, Symbols.x,
                     nil, nil, nil,
                     Symbols.o, Symbols.o, nil]
   assert Board.winning_line?(winning_board) == true
  end

    test "4x4 has no win" do
      winning_board = [Symbols.x, Symbols.x, Symbols.x, nil,
                       nil, nil, nil, nil,
                       Symbols.o, Symbols.o, nil, nil,
                       nil, nil, nil, nil]
     assert Board.winning_line?(winning_board) == false
    end

    test "4x4 has a win in the top row" do
      winning_board = [Symbols.x, Symbols.x, Symbols.x, Symbols.x,
                       nil, nil, nil, nil,
                       Symbols.o, Symbols.o, nil, nil,
                       nil, nil, nil, nil]
     assert Board.winning_line?(winning_board) == true
    end

  test "(3x3) has a win in the middle row" do
    winning_board = [nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o,
                     Symbols.x, Symbols.x, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win in the middle row" do
    winning_board = [nil, nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o, Symbols.o,
                     nil, Symbols.x, Symbols.x, nil,
                   nil, nil, nil, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) has a win in the bottom row" do
    winning_board = [Symbols.x, nil, Symbols.x,
                     nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win in the bottom row" do
    winning_board = [Symbols.x, nil, Symbols.x, nil,
                     nil, nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o, Symbols.o,
                   nil, nil, nil, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) has a win on the left column" do
    winning_board = [Symbols.x, nil, nil,
                     Symbols.x, nil, nil,
                     Symbols.x, Symbols.o, Symbols.o]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win on the left column" do
    winning_board = [Symbols.x, nil, nil, nil,
                     Symbols.x, nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o, Symbols.o,
                     nil, nil, nil, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) has a win on the middle column" do
    winning_board = [nil, Symbols.x, nil,
                     nil, Symbols.x, Symbols.o,
                     nil, Symbols.x, Symbols.o]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win on the middle column" do
    winning_board = [nil, Symbols.x, nil, nil,
                     nil, Symbols.x, nil, Symbols.o,
                     nil, Symbols.x, Symbols.o, nil,
                     nil, Symbols.x, nil, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win on the second middle column" do
    winning_board = [nil, nil, Symbols.x, nil,
                     nil, nil, Symbols.x, Symbols.o,
                     nil, nil, Symbols.x, Symbols.o,
                     nil, nil, Symbols.x, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) has a win on the right column" do
    winning_board = [nil, nil, Symbols.x,
                     nil, nil, Symbols.x,
                     nil, nil, Symbols.x]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win on the right column" do
    winning_board = [nil, nil, nil, Symbols.x,
                     nil, nil, nil, Symbols.x,
                     nil, nil, nil, Symbols.x,
                     nil, nil, nil, Symbols.x]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) has a win on first diagonal" do
    winning_board = [nil, nil, Symbols.x,
                     nil, Symbols.x,nil,
                     Symbols.x, nil, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win on first diagonal" do
    winning_board = [nil, nil, nil, Symbols.x,
                     nil, nil, Symbols.x,nil,
                     nil, Symbols.x, nil, nil,
                     Symbols.x, nil, nil, nil]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) has a win on second diagonal" do
    winning_board = [Symbols.x, nil, nil,
                     nil, Symbols.x,nil,
                     nil, nil, Symbols.x]
   assert Board.winning_line?(winning_board) == true
  end

  test "(4x4) has a win on second diagonal" do
    winning_board = [Symbols.x, nil, nil, nil,
                     nil, Symbols.x,nil, nil,
                     nil, nil, Symbols.x, nil,
                     nil, nil, nil, Symbols.x]
   assert Board.winning_line?(winning_board) == true
  end

  test "(3x3) finds winning symbol in top row" do
    winning_board = [Symbols.x, Symbols.x, Symbols.x,
                     nil, nil, nil,
                     Symbols.o, Symbols.o, nil]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(4x4) finds winning symbol in top row" do
    winning_board = [Symbols.x, Symbols.x, Symbols.x, Symbols.x,
                     nil, nil, nil, nil,
                     Symbols.o, Symbols.o, nil, nil,
                     nil, nil, nil, nil]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(3x3) finds winning symbol in middle row" do
    winning_board = [nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o,
                     Symbols.x, Symbols.x, nil]
   assert Board.winning_symbol(winning_board) == Symbols.o
  end

  test "(4x4) finds winning symbol in middle row" do
    winning_board = [nil, nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o, Symbols.o,
                     Symbols.x, Symbols.x, nil, nil,
                     nil, nil, nil, nil]
   assert Board.winning_symbol(winning_board) == Symbols.o
  end

  test "(3x3) finds winning symbol in bottom row" do
    winning_board = [Symbols.x, nil, Symbols.x,
                     nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o]
   assert Board.winning_symbol(winning_board) == Symbols.o
  end

  test "(4x4) finds winning symbol in bottom row" do
    winning_board = [Symbols.x, nil, Symbols.x, nil,
                     nil, nil, nil, nil,
                     Symbols.o, Symbols.o, Symbols.o, Symbols.o,
                     nil, nil, nil, nil]
   assert Board.winning_symbol(winning_board) == Symbols.o
  end

  test "(3x3) finds winning symbol in left column" do
    winning_board = [Symbols.x, nil, nil,
                     Symbols.x, nil, nil,
                     Symbols.x, Symbols.o, Symbols.o]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(4x4) finds winning symbol in left column" do
    winning_board = [Symbols.x, nil, nil, nil,
                     Symbols.x, nil, nil, nil,
                     Symbols.x, nil, Symbols.o, Symbols.o,
                     Symbols.x, nil, nil, nil]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(3x3) finds winning symbol in middle column" do
    winning_board = [nil, Symbols.x, nil,
                     nil, Symbols.x, nil,
                     nil, Symbols.x, Symbols.o]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(4x4) finds winning symbol in middle column" do
    winning_board = [nil, nil, Symbols.x, nil,
                     nil, nil, Symbols.x, nil,
                     nil, nil, Symbols.x, Symbols.o,
                     nil, nil, Symbols.x, Symbols.o]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(3x3) finds winning symbol in right column" do
    winning_board = [nil, nil, Symbols.x,
                     nil, nil, Symbols.x,
                     nil, nil, Symbols.x]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(4x4) finds winning symbol in right column" do
    winning_board = [nil, nil, nil, Symbols.x,
                     nil, nil, nil, Symbols.x,
                     nil, nil, nil, Symbols.x,
                     nil, nil, nil, Symbols.x]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(3x3) finds winning symbol in first diagonal" do
    winning_board = [nil, nil, Symbols.x,
                     nil, Symbols.x,nil,
                     Symbols.x, nil, nil]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(4x4) finds winning symbol in first diagonal" do
    winning_board = [nil, nil, nil, Symbols.x,
                     nil, nil, Symbols.x,nil,
                     nil, Symbols.x, nil, nil,
                     Symbols.x, nil, nil, nil]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(3x3) finds winning symbol in second diagonal" do
    winning_board = [Symbols.x, nil, nil,
                     nil, Symbols.x, nil,
                     nil, nil, Symbols.x]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "(4x4) finds winning symbol in second diagonal" do
    winning_board = [Symbols.x, nil, nil, nil,
                     nil, Symbols.x, nil, nil,
                     nil, nil, Symbols.x, nil,
                     nil, nil, nil, Symbols.x]
   assert Board.winning_symbol(winning_board) == Symbols.x
  end

  test "has a winning symbol of nil when there is no winning row" do
    assert Board.winning_symbol(Board.create) == nil
  end

  defp full_board_3x3 do
    [Symbols.x, Symbols.x, Symbols.o,
     Symbols.o, Symbols.x, Symbols.o,
     Symbols.x, Symbols.o, Symbols.x]
  end
end
