defmodule Players.HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias GameBoard.Board
  alias Player.HumanPlayer

  test "provides next move" do
    capture_io("5\n",
    fn ->
      assert Board.create
             |> HumanPlayer.choose_move == 4
    end)
  end
end
