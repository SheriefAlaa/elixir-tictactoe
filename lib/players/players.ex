defmodule Players.Players do
  alias PlayerSymbols, as: Symbols
  alias Player.HumanPlayer
  alias Player.MinimaxPlayer
  alias Player.Minimax4x4Player
  alias Players.MoveDelayer

  @dimension_3 GameBoard.BoardDimension.dimension_3
  @dimension_4 GameBoard.BoardDimension.dimension_4

  def for_game(game_type, dimension) do
    cond do
      matches?(game_type, GameType.human_vs_human) ->
        configure_players(human_player, human_player)
      matches?(game_type, GameType.human_vs_computer) ->
        configure_players(human_player, computer_player_for(dimension))
      matches?(game_type, GameType.computer_vs_human) ->
        configure_players(computer_player_for(dimension), human_player)
      true ->
        configure_players(delayed_minimax_player(dimension), delayed_minimax_player(dimension))
    end
  end

  def delayed_move_for(player) do
    fn(board) -> MoveDelayer.delay_move(fn-> :timer.sleep(500) end, player, board) end
  end

  defp delayed_minimax_player(dimension) do
    case dimension do
      @dimension_3 -> delayed_move_for(MinimaxPlayer)
      @dimension_4 -> delayed_move_for(Minimax4x4Player)
    end
  end

  defp human_player, do: &(HumanPlayer.choose_move/1)

  defp computer_player_for(dimension) do
    case dimension do
      @dimension_3 -> &(MinimaxPlayer.choose_move/1)
      @dimension_4 -> &(Minimax4x4Player.choose_move/1)
    end
  end

  defp matches?(game_type, option), do: game_type == option

  defp configure_players(player_x, player_o) do
    %{Symbols.x => player_x,
      Symbols.o => player_o}
  end
end
