defmodule TTT do
  alias GameBoard.Board
  alias GameBoard.NextSymbolCalculator
  alias Players.Players
  alias Prompt.InputValidatingPrompt

  def start() do
    start(InputValidatingPrompt)
  end

  def start(prompt) do
    play_game(prompt)
    prompt.goodbye
  end

  def play_game(prompt) do
    dimension = prompt.get_valid_dimension

    prompt.get_valid_game_type
    |> configure_players(dimension)
    |> play_move(prompt, Board.create(dimension))

    if prompt.play_again?, do: play_game(prompt)
  end

  def play_move(players, prompt, board) do
    updated_board = update_board(board, players)
    prompt.display(board)
    cond do
      win?(updated_board) -> prompt.announce_win(updated_board)
      draw?(updated_board) -> prompt.announce_draw(updated_board)
      true -> play_move(players, prompt, updated_board)
    end
  end

  def update_board(board, players) do
    next_symbol = next_symbol(board)
    move = get_players_move(board, next_symbol, players)
    update_board(board, move, next_symbol)
  end

  defp configure_players(game_type, dimension) do
    Players.for_game(game_type, dimension)
  end

  defp next_symbol(board), do: NextSymbolCalculator.next_symbol(board)

  defp get_players_move(board, next_symbol, players) do
    Map.get(players, next_symbol).(board)
  end

  defp update_board(board, move, symbol), do: Board.update(board, move, symbol)
  defp win?(board), do: Board.winning_line?(board)

  defp draw?(board), do: !Board.free_spaces?(board)
end
