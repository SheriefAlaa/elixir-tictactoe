defimpl Player, for: MinimaxPlayer do
  alias GameBoard.Board
  alias GameBoard.NextSymbolCalculator

  @max_winning_score 10
  @min_winnning_score -10
  @draw_score 0
  @move_placeholder -1
  @max_initial_score -100
  @min_initial_score 100
  @initial_alpha -100
  @initial_beta 100
  @smallest_depth_for_no_forks 6

  def choose_move(board) do
    {best_scoring_move, _} = minimax(board,
                                     @smallest_depth_for_no_forks,
                                     max_player,
                                     next_symbol_to_be_made_on(board),
                                     @initial_alpha,
                                     @initial_beta)
    best_scoring_move
  end

  defp max_player, do: true

  defp next_symbol_to_be_made_on(board), do: NextSymbolCalculator.next_symbol(board)

  defp minimax(board, remaining_depth, is_max_player, max_player_symbol, alpha, beta) do
    if game_over?(board) do
      calculate_game_over_score(board, remaining_depth, max_player_symbol)
    else
      find_best_scoring_position(free_spaces_on(board),
                                 calculate_initial_score(is_max_player),
                                 board,
                                 remaining_depth,
                                 is_max_player,
                                 max_player_symbol,
                                 alpha,
                                 beta)
    end
  end

  defp game_over?(board), do: has_win?(board) or no_free_spaces(board)

  defp has_win?(board), do: Board.winning_line?(board)

  defp no_free_spaces(board), do: not(Board.free_spaces?(board))

  def calculate_game_over_score(board, remaining_depth, max_player_symbol) do
    has_win?(board)
    |> game_over_score(remaining_depth, board, max_player_symbol)
  end

  defp game_over_score(true, remaining_depth, board, max_player_symbol) do
    max_player_won?(board, max_player_symbol)
    |> calculate_winners_score(remaining_depth)
  end
  defp game_over_score(false, _, _, _), do: {@move_placeholder, @draw_score}

  defp calculate_winners_score(true, remaining_depth) do
    {@move_placeholder, @max_winning_score + remaining_depth}
  end
  defp calculate_winners_score(false, remaining_depth) do
    {@move_placeholder, @min_winnning_score - remaining_depth}
  end

  defp max_player_won?(board, max_player_symbol) do
    Board.winning_symbol(board) == max_player_symbol
  end

  defp calculate_initial_score(true), do: {@move_placeholder, @max_initial_score}
  defp calculate_initial_score(false), do: {@move_placeholder, @min_initial_score}

  defp free_spaces_on(board), do: Board.indicies_of_free_spaces(board)

  defp find_best_scoring_position([], best_score, _, _, _, _, _, _) do
    best_score
  end
  defp find_best_scoring_position([first_free_slot|tail], best_score, board, remaining_depth, is_max_player, max_player_symbol, alpha, beta) do
    current_scoring_position = update_board(board, first_free_slot)
                               |> minimax(decrement(remaining_depth),
                                          not(is_max_player),
                                          max_player_symbol,
                                          alpha,
                                          beta)

    updated_best_score = get_players_best_scoring_position(is_max_player,
                                                           best_score,
                                                           current_scoring_position,
                                                           first_free_slot)

    updated_alpha = recalculate_alpha(is_max_player, updated_best_score, alpha)
    updated_beta = recalculate_beta(is_max_player, updated_best_score, beta)

   if prune?(updated_alpha, updated_beta, remaining_depth) do
     updated_best_score
   else
     find_best_scoring_position(tail, updated_best_score, board, remaining_depth,
                                is_max_player, max_player_symbol, updated_alpha, updated_beta)
   end
  end

  defp update_board(board, move) do
    Board.update(board, move, NextSymbolCalculator.next_symbol(board))
  end

  defp decrement(depth), do: depth - 1

  defp get_players_best_scoring_position(is_max_player, current_best, position, move) do
    if is_max_player do
      calculate_score(current_best, position, move, scoring_for_max)
    else
      calculate_score(current_best, position, move, scoring_for_min)
    end
  end

  defp calculate_score({best_position_move, best_position_score}, {_, valued_position_score}, move, predicate) do
    if predicate.(best_position_score, valued_position_score), do: {move, valued_position_score}, else: {best_position_move, best_position_score}
  end

  def prune?(alpha, beta, depth) do
    alpha >= beta or depth <= 0
  end

  def recalculate_alpha(is_max_player, {_, score}, alpha) do
    if is_max_player, do: max(score, alpha), else: alpha
  end

  def recalculate_beta(is_max_player, {_, score}, beta) do
    if is_max_player, do: beta, else: min(score, beta)
  end

  defp scoring_for_max do
    fn(current_best_score, latest_score) -> current_best_score < latest_score end
  end

  defp scoring_for_min do
    fn(current_best_score, latest_score) -> current_best_score > latest_score end
  end
end
