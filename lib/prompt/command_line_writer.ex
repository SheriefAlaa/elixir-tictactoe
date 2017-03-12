defmodule Prompt.CommandLineWriter do
  alias GameBoard.BoardFormatter
  alias Prompt.BoardPresenter

  @prompt_wording_for_next_move "Please enter your next move"
  @not_numeric_wording "Input is not numeric!"
  @not_free_space_wording "Input is not a free space!"
  @prompt_wording_for_game_type "Please enter"
  @not_valid_game_type_wording "Input is not a valid game type!"

  def prompt_wording_for_next_move, do: @prompt_wording_for_next_move
  def not_numeric_wording, do: @not_numeric_wording
  def not_free_space_wording, do: @not_free_space_wording
  def prompt_wording_for_game_type, do: @prompt_wording_for_game_type
  def not_valid_game_type_wording, do: @not_valid_game_type_wording

  def prompt_for_board_dimension do
    write("Please enter board dimension: #{BoardDimension.for_display}")
  end

  def prompt_for_game_type do
    write(@prompt_wording_for_game_type)
    write("#{GameType.for_display}")
  end

  def prompt_for_next_move, do: write(prompt_wording_for_next_move)

  def prompt_to_play_again(play_again_value) do
    write("Play again? (#{play_again_value} to start a new game)")
  end

  def display_win_message(winning_symbol), do: write("#{winning_symbol} has won!")

  def display_draw_message, do: write("It is a draw!")

  def display_input_is_not_numeric_message, do: write(not_numeric_wording)

  def display_input_is_not_free_space, do: write(not_free_space_wording)

  def display_input_is_not_a_valid_game_type, do: write(not_valid_game_type_wording)

  def display(board) do
    BoardFormatter.format(board)
    |> BoardPresenter.display
  end

  def display_goodbye, do: write("Goodbye!")

  defp write(message), do: IO.puts(message)
end
