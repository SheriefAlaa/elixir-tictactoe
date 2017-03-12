defmodule Prompt.BoardPresenterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias IO.ANSI, as: ANSI
  alias GameBoard.BoardFormatter, as: BoardFormatter
  alias GameBoard.Board, as: Board
  alias PlayerSymbols, as: Symbols
  alias Prompt.BoardPresenter, as: BoardPresenter

  test "displays an empty 3x3 board" do
    board = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]

    output = capture_io(fn -> BoardPresenter.display(board) end)
    assert output == ansi_characters_for_clearing_screen <>
    "[  1  ][  2  ][  3  ]\n[  4  ][  5  ][  6  ]\n[  7  ][  8  ][  9  ]\n"
  end

  test "displays a 3x3 board with moves" do
    board = [[1, Symbols.x, 3],
             [4, 5, Symbols.o],
             [7, 8, 9]]

    output =  assert capture_io(fn -> BoardPresenter.display(board) end)
    assert output == ansi_characters_for_clearing_screen <>
    "[  1  ][  X  ][  3  ]\n[  4  ][  5  ][  O  ]\n[  7  ][  8  ][  9  ]\n"
  end

  test "displays an empty 4x4 board" do
    board = Board.create(4)
            |> BoardFormatter.format

    output = capture_io(fn -> BoardPresenter.display(board) end)
    assert output == ansi_characters_for_clearing_screen <> expected_4x4_board
  end

  defp ansi_characters_for_clearing_screen do
    ANSI.clear <> new_line <> ANSI.home <> new_line
  end

  defp new_line do
    "\n"
  end

  defp expected_4x4_board do
    "[  1  ][  2  ][  3  ][  4  ]\n[  5  ][  6  ][  7  ][  8  ]\n[  9  ][  10 ][  11 ][  12 ]\n[  13 ][  14 ][  15 ][  16 ]\n"
  end
end
