defmodule GameBoard.NextSymbolCalculator do

  def next_symbol(board) do
    cond do
      player_o_should_have_next_turn(board) -> PlayerSymbols.o
      true -> PlayerSymbols.x
    end
  end

  defp count_symbol(player_symbol, board) do
    Enum.count(board, &(&1 == player_symbol))
  end

  defp player_o_should_have_next_turn(board) do
    count_symbol(PlayerSymbols.x, board) > count_symbol(PlayerSymbols.o, board)
  end
end
