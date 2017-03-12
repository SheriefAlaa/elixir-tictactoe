defmodule Players.MinimaxPlayerTest do
  use ExUnit.Case
  alias PlayerSymbols, as: Symbols
  alias Player.MinimaxPlayer, as: MinimaxPlayer

  test "takes winning move on top row" do
    board = [Symbols.x, Symbols.x, nil,
             Symbols.o, Symbols.o, nil,
             nil, nil, nil]

    assert MinimaxPlayer.choose_move(board) == 2
  end

  test "takes winning move on middle row" do
    board = [nil, nil, nil,
             Symbols.x, Symbols.x, nil,
             Symbols.o, Symbols.o, nil]

    assert MinimaxPlayer.choose_move(board) == 5
  end

  test "takes winning move on bottom row" do
    board = [nil, nil, nil,
             Symbols.o, Symbols.o, nil,
             Symbols.x, Symbols.x, nil]

    assert MinimaxPlayer.choose_move(board) == 8
  end

  test "takes winning move on left column" do
    board = [Symbols.x, Symbols.o, nil,
             Symbols.x, Symbols.o, nil,
             nil, nil, nil]

    assert MinimaxPlayer.choose_move(board) == 6
  end

  test "takes winning move on middle column" do
    board = [nil, Symbols.x, Symbols.o,
             nil, Symbols.x, Symbols.o,
             nil, nil, nil]

    assert MinimaxPlayer.choose_move(board) == 7
  end

  test "takes winning move on right column" do
    board = [nil, Symbols.o, Symbols.x,
             nil, Symbols.o, Symbols.x,
             nil, nil, nil]

    assert MinimaxPlayer.choose_move(board) == 8
  end

  test "takes winning first diagonal" do
    board = [nil, Symbols.o, Symbols.x,
             nil, Symbols.x, Symbols.o,
             nil, nil, nil]

    assert MinimaxPlayer.choose_move(board) == 6
  end

  test "takes winning second diagonal" do
    board = [nil, Symbols.o, nil,
             nil, Symbols.x, Symbols.o,
             nil, nil, Symbols.x]

    assert MinimaxPlayer.choose_move(board) == 0
  end

  test "blocks opponent win in top row" do
    board = [Symbols.o, Symbols.o, nil,
             nil, Symbols.x, nil,
             nil, nil, Symbols.x]

     assert MinimaxPlayer.choose_move(board) == 2
  end

  test "blocks opponent win in middle row" do
    board = [nil, nil, Symbols.x,
             nil, Symbols.o, Symbols.o,
             nil, Symbols.x, nil]

     assert MinimaxPlayer.choose_move(board) == 3
  end

  test "blocks opponent win in bottom row" do
    board = [nil, nil, Symbols.x,
             nil, Symbols.x, nil,
             Symbols.o, Symbols.o, nil]

     assert MinimaxPlayer.choose_move(board) == 8
  end

  test "blocks opponent win in left column" do
    board = [Symbols.o, nil, Symbols.x,
             nil, Symbols.x, nil,
             Symbols.o, nil, nil]

     assert MinimaxPlayer.choose_move(board) == 3
  end

  test "blocks opponent win in middle column" do
    board = [nil, Symbols.o, nil,
             Symbols.x, nil, nil,
             nil, Symbols.o, Symbols.x]

     assert MinimaxPlayer.choose_move(board) == 4
  end

  test "blocks opponent win in the right column" do
    board = [nil, Symbols.x, Symbols.o,
             Symbols.x, nil, nil,
             nil, nil, Symbols.o]

     assert MinimaxPlayer.choose_move(board) == 5
  end

  test "blocks opponent win in first diagonal" do
    board = [nil, Symbols.x, Symbols.o,
             nil, Symbols.o, nil,
             nil, nil, Symbols.x]

     assert MinimaxPlayer.choose_move(board) == 6
  end

  test "blocks opponent win in the second diagonal" do
    board = [nil, Symbols.x, nil,
             nil, Symbols.o, Symbols.x,
             nil, nil, Symbols.o]

     assert MinimaxPlayer.choose_move(board) == 0
  end

  test "takes middle space when top left is occupied" do
    board = [Symbols.x, nil, nil,
             nil, nil, nil,
             nil, nil, nil]

     assert MinimaxPlayer.choose_move(board) == 4
  end

  test "does not allow a fork to form" do
    board = [Symbols.x, nil, nil,
             nil, Symbols.o, nil,
             nil, nil, Symbols.x]
    assert MinimaxPlayer.choose_move(board) == 1
  end
end
