defmodule Players.MoveDelayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias GameBoard.Board
  alias Players.MoveDelayer

  defimpl Player, for: PlayerStub do
    def choose_move(_) do
      IO.puts "Player made move"
    end
  end

  test "move is delayed until after some other behaviour has executed" do
    assert capture_io(fn ->
      MoveDelayer.delay_move(fn -> IO.puts "Delay!" end,
                             Player.PlayerStub,
                             Board.create)
    end) == "Delay!\nPlayer made move\n"
  end
end
