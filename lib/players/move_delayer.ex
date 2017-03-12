defmodule Players.MoveDelayer do

  def delay_move(pre_move_behaviour, player, board) do
    pre_move_behaviour.()
    player.choose_move(board)
  end
end
