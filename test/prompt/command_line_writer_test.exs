defmodule Prompt.CommandLineWriterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias GameBoard.Board, as: Board
  alias Prompt.CommandLineWriter, as: CommandLineWriter

  @clear_screen "\e[2J\n\e[H\n"

    test "prompts for board dimension" do
      assert capture_io(fn ->
        CommandLineWriter.prompt_for_board_dimension
      end) == "Please enter board dimension: 3 or 4\n"
    end

    test "prompts for game type" do
      assert capture_io(fn ->
        CommandLineWriter.prompt_for_game_type
      end) == "Please enter\n#{GameType.for_display}\n"
    end

    test "prompts user for next move" do
      assert capture_io(fn ->
        CommandLineWriter.prompt_for_next_move
      end) == "Please enter your next move\n"
    end

    test "displays winning message" do
      assert capture_io(fn ->
        CommandLineWriter.display_win_message(PlayerSymbols.x)
      end) == "X has won!\n"
    end

    test "displays draw message" do
      assert capture_io(fn ->
        CommandLineWriter.display_draw_message
      end) == "It is a draw!\n"
    end

    test "displays invalid number message" do
      assert capture_io(fn ->
        CommandLineWriter.display_input_is_not_numeric_message
      end) == "Input is not numeric!\n"
    end

    test "displays occupied space message" do
      assert capture_io(fn ->
        CommandLineWriter.display_input_is_not_free_space
      end) == "Input is not a free space!\n"
    end

    test "displays invalid game type message" do
      assert capture_io(fn ->
        CommandLineWriter.display_input_is_not_a_valid_game_type
      end) == "Input is not a valid game type!\n"
    end

    test "formats and displays board" do
      assert capture_io(fn ->
        CommandLineWriter.display(Board.create)
      end) == @clear_screen <> "[  1  ][  2  ][  3  ]\n[  4  ][  5  ][  6  ]\n[  7  ][  8  ][  9  ]\n"
    end

    test "prompts to replay" do
      assert capture_io(fn ->
        CommandLineWriter.prompt_to_play_again("Y")
      end) == "Play again? (Y to start a new game)\n"
    end

    test "says goodbye" do
      assert capture_io(fn ->
        CommandLineWriter.display_goodbye()
      end) == "Goodbye!\n"
    end
end
