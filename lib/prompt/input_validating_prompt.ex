defmodule Prompt.InputValidatingPrompt do
  alias GameBoard.Board
  alias Prompt.CommandLineWriter
  alias Prompt.ConsoleCleaner
  alias Prompt.NumberFormatter
  alias Prompt.CommandLineReader

  @play_again "Y"

  def get_valid_dimension(writer \\CommandLineWriter) do
    clear_screen
    reprompt_until_valid(fn -> prompt_for_board_dimension(writer) end,
                         fn(input) -> validation_conditions_for_dimension(input) end,
                         fn(input) -> format_dimension(input) end)
  end

  def get_valid_game_type(writer \\CommandLineWriter) do
    clear_screen
    reprompt_until_valid(fn -> prompt_for_game_type(writer) end,
                         fn(input) -> validation_conditions_for_game_type(input) end,
                         fn(input) -> format_game_type(input) end)
  end

  def get_valid_move(board, writer \\CommandLineWriter) do
    display(board, writer)
    reprompt_until_valid(fn -> prompt_for_next_move(writer) end,
                         fn(input) -> validation_conditions_for_move(board, input, writer) end,
                         fn(input) -> zero_based_value(input) end)
  end

  def display(board, writer \\CommandLineWriter), do: writer.display(board)

  def announce_win(board, writer \\CommandLineWriter) do
    display(board, writer)
    writer.display_win_message(Board.winning_symbol(board))
  end

  def announce_draw(board, writer \\CommandLineWriter) do
    display(board, writer)
    writer.display_draw_message
  end

  def play_again?(writer \\CommandLineWriter) do
    writer.prompt_to_play_again(@play_again)
    read_input
    |> validate_play_again_option
  end

  def goodbye(writer \\CommandLineWriter), do: writer.display_goodbye

  defp clear_screen, do: ConsoleCleaner.refresh

  defp reprompt_until_valid(prompt_user, validation_conditions, format) do
    prompt_user.()
    player_input = read_input

    if validation_conditions.(player_input) do
      format.(player_input)
    else
      reprompt_until_valid(prompt_user, validation_conditions, format)
    end
  end

  defp read_input, do: CommandLineReader.read

  defp prompt_for_board_dimension(writer), do: writer.prompt_for_board_dimension

  defp validation_conditions_for_dimension(input) do
    is_numeric?(input) and valid_dimension?(input)
  end

  defp is_numeric?(input) do
    validate_with_error_message(fn -> NumberFormatter.is_integer?(input) end,
                                fn -> clear_screen end)
  end

  defp validate_with_error_message(predicate, error_msg) do
    if predicate.() do
      true
    else
      error_msg.()
      false
    end
  end

  defp valid_dimension?(input) do
    validate_with_error_message(fn -> is_valid_dimension?(input) end,
                                fn-> clear_screen end)
  end

  defp is_valid_dimension?(input) do
    NumberFormatter.to_integer(input)
    |> BoardDimension.valid_dimension?
  end

  defp format_dimension(input) do
    String.strip(input)
    |> NumberFormatter.to_integer
  end

  defp prompt_for_game_type(writer), do: writer.prompt_for_game_type

  defp validation_conditions_for_game_type(input) do
    is_numeric?(input) and
    validate_with_error_message(fn -> valid_game_type?(input) end,
                                fn -> clear_screen end)
  end

  defp valid_game_type?(input) do
    NumberFormatter.to_integer(input)
    |> GameType.is_valid?
  end

  defp validation_conditions_for_move(board, input, writer) do
    is_move_numeric?(board, input, writer) and is_valid_space(board, input, writer)
  end

  defp is_valid_space(board, input, writer) do
    validate_with_error_message(fn -> Board.free_space_at?(zero_based_value(input), board) end,
                                fn -> display_board_with_invalid_move_message(board, writer) end)
  end

  defp display_board_with_invalid_number_message(board, writer) do
    display(board, writer)
    writer.display_input_is_not_numeric_message
  end

  defp zero_based_value(input), do: NumberFormatter.zero_based_value(input)

  defp validate_play_again_option(input), do: String.upcase(input) == @play_again

  defp prompt_for_next_move(writer), do: writer.prompt_for_next_move

  defp is_move_numeric?(board, input, writer) do
    validate_with_error_message(fn -> NumberFormatter.is_integer?(input) end,
                                fn -> display_board_with_invalid_number_message(board, writer) end)
  end

  defp format_game_type(player_choice) do
    NumberFormatter.to_integer(player_choice)
    |> GameType.with_id
  end

  defp display_board_with_invalid_move_message(board, writer) do
    display(board, writer)
    writer.display_input_is_not_free_space
  end
end
