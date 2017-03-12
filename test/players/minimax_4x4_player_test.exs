defmodule Players.Minimax4x4PlayerTest do
  use ExUnit.Case
  alias GameBoard.Board
  alias PlayerSymbols, as: Symbols
  alias Player.Minimax4x4Player

  test "takes first cell on empty board" do
    move = Board.create
           |> Minimax4x4Player.choose_move
    assert move == 0
  end

  test "takes second cell when there is one move on the board" do
    board = [Symbols.x, nil, nil, nil,
             nil, nil, nil, nil,
             nil, nil, nil, nil,
             nil, nil, nil, nil]

    assert Minimax4x4Player.choose_move(board) == 1
  end

  test "takes first free cell when there are 10 spaces" do
    board = [Symbols.x, Symbols.o, nil, Symbols.x,
             nil, nil, nil, Symbols.o,
             nil, nil, Symbols.o, Symbols.o,
             Symbols.x, nil, nil, Symbols.x]

    assert Minimax4x4Player.choose_move(board) == Board.indicies_of_free_spaces(board)
                                                  |> List.first
  end

  test "takes winning move on top row" do
    board = [Symbols.x, Symbols.x, Symbols.x, nil,
             Symbols.o, Symbols.o, nil, nil,
             nil, nil, nil, nil,
             Symbols.o, nil, nil, nil]

    assert Minimax4x4Player.choose_move(board) == 3
  end

  test "takes winning move on second row" do
    board = [Symbols.o, nil, nil, nil,
             Symbols.x, Symbols.x, Symbols.x, nil,
             nil, Symbols.o, Symbols.o, nil,
             Symbols.x, nil, nil, Symbols.o]

    assert Minimax4x4Player.choose_move(board) == 7
  end

  test "takes winning move on the third row" do
    board = [nil, nil, nil, nil,
             Symbols.o, Symbols.o, nil, nil,
             Symbols.x, Symbols.x, Symbols.x, nil,
             Symbols.x, Symbols.o, Symbols.o, nil]

    assert Minimax4x4Player.choose_move(board) == 11
  end

  test "takes winning move on first column" do
    board = [Symbols.x, Symbols.o, nil, nil,
             Symbols.x, Symbols.o, nil, nil,
             Symbols.x, nil, Symbols.x, Symbols.o,
             nil, nil, nil, Symbols.o]

    assert Minimax4x4Player.choose_move(board) == 12
  end

  test "takes winning move on second column" do
    board = [nil, Symbols.x, Symbols.o, Symbols.x,
             nil, Symbols.x, Symbols.o, Symbols.o,
             nil, nil, nil, nil,
             nil, Symbols.x, nil, Symbols.o]

    assert Minimax4x4Player.choose_move(board) == 9
  end

  test "takes winning move on third column" do
    board = [nil, Symbols.o, Symbols.x, Symbols.x,
             nil, Symbols.o, Symbols.x, Symbols.o,
             Symbols.x, nil, Symbols.x, nil,
             Symbols.o, nil, nil, Symbols.o]

    assert Minimax4x4Player.choose_move(board) == 14
  end

  test "takes winning move on fourth column" do
    board = [nil, Symbols.o, nil, Symbols.x,
             Symbols.o, Symbols.x, nil, nil,
             nil, nil, Symbols.o, Symbols.x,
             nil, Symbols.o, nil, Symbols.x]

    assert Minimax4x4Player.choose_move(board) == 7
  end

  test "takes winning first diagonal" do
    board = [Symbols.x, Symbols.o, Symbols.o, Symbols.x,
             nil, nil, Symbols.x, Symbols.o,
             nil, Symbols.x, nil, Symbols.o,
             nil, nil, Symbols.o, Symbols.x]

    assert Minimax4x4Player.choose_move(board) == 12
  end

  test "takes winning second diagonal" do
    board = [nil, Symbols.o, nil, nil,
             nil, Symbols.x, Symbols.o, nil,
             nil, nil, Symbols.x, nil,
             Symbols.x, Symbols.o, nil, Symbols.x]

    assert Minimax4x4Player.choose_move(board) == 0
  end

  test "blocks opponent win in first row" do
    board = [Symbols.o, Symbols.o, Symbols.o, nil,
             nil, Symbols.x, nil, nil,
             nil, nil, Symbols.x, Symbols.x,
             nil, nil, nil, Symbols.o]

     assert Minimax4x4Player.choose_move(board) == 3
  end

  test "blocks opponent win in second row" do
    board = [Symbols.x, Symbols.o, Symbols.x, nil,
             Symbols.o, Symbols.o, Symbols.o, nil,
             nil, Symbols.x, Symbols.x, nil,
             nil, nil, nil, Symbols.o]

     assert Minimax4x4Player.choose_move(board) == 7
  end

  test "blocks opponent win in third row" do
    board = [nil, nil, Symbols.x, Symbols.o,
             nil, Symbols.x, Symbols.x, nil,
             Symbols.o, Symbols.o, nil, Symbols.o,
             Symbols.x, nil, nil, nil]

     assert Minimax4x4Player.choose_move(board) == 10
  end

  test "blocks opponent win in first column" do
    board = [Symbols.o, nil, Symbols.x, nil,
             nil, Symbols.x, nil, nil,
             Symbols.o, nil, nil, Symbols.o,
             Symbols.o, nil, nil, Symbols.x]

     assert Minimax4x4Player.choose_move(board) == 4
  end

  test "blocks opponent win in second column" do
    board = [nil, Symbols.o, nil, nil,
             Symbols.x, nil, nil, nil,
             nil, Symbols.o, Symbols.x, nil,
             nil, Symbols.o, nil, Symbols.x]

     assert Minimax4x4Player.choose_move(board) == 5
  end

  test "blocks opponent win in the third column" do
    board = [nil, Symbols.x, Symbols.o, nil,
             Symbols.x, nil, nil, nil,
             nil, nil, Symbols.o, nil,
             Symbols.x, Symbols.o, Symbols.o, Symbols.x]

     assert Minimax4x4Player.choose_move(board) == 6
  end

  test "blocks opponent win in the fourth column" do
    board = [nil, Symbols.x, Symbols.o, nil,
             Symbols.x, nil, nil, Symbols.o,
             nil, nil, nil, Symbols.o,
             nil, Symbols.x, nil, Symbols.o]

     assert Minimax4x4Player.choose_move(board) == 3
  end

  test "blocks opponent win in first diagonal" do
    board = [Symbols.x, Symbols.x, Symbols.x, Symbols.o,
             nil, nil, Symbols.o, nil,
             nil, Symbols.o, nil, Symbols.x,
             nil, nil, nil, nil]

     assert Minimax4x4Player.choose_move(board) == 12
  end

  test "blocks opponent win in the second diagonal" do
    board = [nil, Symbols.x, Symbols.o, Symbols.x,
             nil, Symbols.o, Symbols.x, Symbols.o,
             nil, nil, Symbols.o, Symbols.x,
             nil, nil, nil, Symbols.o]

     assert Minimax4x4Player.choose_move(board) == 0
  end
end
