defimpl Player, for: Minimax4x4Player do
  alias GameBoard.Board
  alias Player.MinimaxPlayer

  @smart_move_entry_level 11

  def choose_move(board) do
    cond do
      eligible_for_smart_move?(board) -> take_smart_move(board)
      true -> take_first_free_space(board)
    end
  end

  defp eligible_for_smart_move?(board) do
    number_of_free_spaces(board) <= @smart_move_entry_level
  end

  defp number_of_free_spaces(board) do
    Board.indicies_of_free_spaces(board)
    |> Enum.count
  end

  defp take_smart_move(board), do: MinimaxPlayer.choose_move(board)

  defp take_first_free_space(board) do
    Board.indicies_of_free_spaces(board)
    |> List.first
  end
end
