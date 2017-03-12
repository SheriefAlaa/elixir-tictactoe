defmodule Prompt.InputValidatingPromptTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias GameBoard.Board, as: Board
  alias GameBoard.BoardDimension, as: BoardDimension
  alias PlayerSymbols, as: Symbols
  alias Prompt.InputValidatingPrompt, as: InputValidatingPrompt

  @console_prompt ">"
  @new_line "\n"
  @clear_screen "\e[2J\n\e[H\n"

    defmodule WriterStub do
      def display(_), do: IO.puts("Board Printed")
      def prompt_to_play_again(_), do: IO.puts("Play again")
      def display_win_message(_), do: IO.puts("Win")
      def display_draw_message, do: IO.puts("Draw")
      def display_goodbye, do: IO.puts("Bye")
      def prompt_for_board_dimension, do: IO.puts("Dimension")
      def prompt_for_game_type, do: IO.puts("GameType")
      def display_input_is_not_numeric_message, do: IO.puts("Not number")
      def prompt_for_next_move, do: IO.puts("Next move")
      def display_input_is_not_free_space, do: IO.puts("Occupied")
    end

    test "clears screen when asking for dimension" do
      output = capture_io("3\n", fn -> InputValidatingPrompt.get_valid_dimension(WriterStub) end)
      assert output == @clear_screen <> "Dimension" <> @new_line <> @console_prompt
    end

    test "reprompts every time an invalid dimension is entered" do
      output = capture_io("A\n5\n3\n", fn ->
        InputValidatingPrompt.get_valid_dimension(WriterStub)
      end)

      assert number_of_occurances_of(@clear_screen <> "Dimension", output) == 3
    end

    test "reads users choice of board dimension" do
      capture_io("3\n", fn ->
        input = InputValidatingPrompt.get_valid_dimension(WriterStub)
        assert input == BoardDimension.dimension_3
      end)
    end

    test "clears screen when asking for game type" do
      output = capture_io("1\n", fn ->
        InputValidatingPrompt.get_valid_game_type(WriterStub)
      end)
      assert output == @clear_screen <> "GameType" <> @new_line <> @console_prompt
    end

    test "returns valid game type" do
      capture_io("1\n", fn ->
        input = InputValidatingPrompt.get_valid_game_type
        assert input == GameType.human_vs_human
      end)
    end

    test "reads input until a valid game type is entered" do
      capture_io("A\n6\n1\n", fn ->
        input = InputValidatingPrompt.get_valid_game_type
        assert input == GameType.human_vs_human
      end)
    end

    test "reprompts clears screen and asks user for game type" do
      console_output = capture_io("A\n7\n1\n", fn ->
        InputValidatingPrompt.get_valid_game_type(WriterStub)
      end)

      assert number_of_occurances_of(@clear_screen <> "GameType", console_output) == 3
    end

    test "displays board when asking for move" do
      output = capture_io("1\n", fn ->
        Board.create
        |> InputValidatingPrompt.get_valid_move(WriterStub)
      end)

      assert output == "Board Printed\nNext move\n>"
    end

    test "converts valid move to zero based index" do
      capture_io("1\n", fn ->
        input = Board.create
                |> InputValidatingPrompt.get_valid_move
        assert input == 0
      end)
    end

    test "reads until valid move is input" do
      capture_io("A\n1\n", fn ->
        result =  Board.create
                  |> InputValidatingPrompt.get_valid_move
        assert result == 0
      end)
    end

    test "reprompts until a number for a vacant cell is received for move" do
      console_output = capture_io("10\n1\n", fn ->
        Board.create
        |> InputValidatingPrompt.get_valid_move(WriterStub)
      end)

      assert console_output == "Board Printed\nNext move\n>Board Printed\nOccupied\nNext move\n>"
    end

    test "reprompts until a valid number is received for move" do
      console_output = capture_io("1.0\n1\n", fn ->
        Board.create
        |> InputValidatingPrompt.get_valid_move(WriterStub)
      end)

      assert String.contains?(console_output, "Not number")
      assert number_of_occurances_of("Next move" <> @new_line <> @console_prompt, console_output) == 2
    end

    test "displays board" do
      console_output = capture_io(fn ->
        InputValidatingPrompt.display(Board.create, WriterStub)
      end)

      assert console_output ==  "Board Printed" <> @new_line
    end

    test "announces win" do
      winning_board = [Symbols.x, Symbols.o, Symbols.x,
       Symbols.x, Symbols.o, Symbols.o,
       Symbols.x, Symbols.x, Symbols.o]

     console_output = capture_io(fn ->
       InputValidatingPrompt.announce_win(winning_board, WriterStub)
     end)

     assert console_output == "Board Printed\nWin\n"
    end

    test "announces draw" do
      drawn_board = [nil, Symbols.o, Symbols.x,
       Symbols.o, Symbols.o, Symbols.x,
       Symbols.x, Symbols.x, Symbols.o]

      console_output = capture_io(fn ->
        InputValidatingPrompt.announce_draw(drawn_board, WriterStub)
      end)

        assert console_output == "Board Printed\nDraw\n"
    end

    test "asks user to play again" do
      output = capture_io("n\n", fn ->
         InputValidatingPrompt.play_again?(WriterStub)
      end)

      assert output == "Play again" <> @new_line <> @console_prompt
    end

    test "reads y to play again" do
      capture_io("y\n", fn ->
        input = InputValidatingPrompt.play_again?
        assert input == true
      end)
    end

    test "reads Y to play again" do
      capture_io("Y\n", fn ->
        input = InputValidatingPrompt.play_again?
        assert input == true
      end)
    end

    test "reads n to not play again" do
      capture_io("n\n", fn ->
        input = InputValidatingPrompt.play_again?
        assert input == false
      end)
    end

    test "says goodbye" do
      output = capture_io(fn -> InputValidatingPrompt.goodbye end)
      assert output == "Goodbye!\n"
    end

    defp number_of_occurances_of(phrase, output) do
      String.split(output, phrase)
      |> Enum.count(fn(x) -> x != "" end)
    end
end
