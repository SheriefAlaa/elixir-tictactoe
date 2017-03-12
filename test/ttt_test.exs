defmodule TTTTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias GameBoard.Board, as: Board
  alias PlayerSymbols, as: Symbols
  alias Prompt.InputValidatingPrompt, as: InputValidatingPrompt

  @dimension_choice "3\n"
  @game_choice  "1\n"
  @play_again "Y\n"
  @dont_play_again "N\n"

  defmodule PromptStub do
    def get_valid_dimension, do: 3
    def get_valid_game_type, do: GameType.human_vs_human
    def get_valid_move, do: 2
    def display(_), do: IO.puts("Board")
    def announce_win(_), do: IO.puts("Win")
    def announce_draw(_), do: IO.puts("Draw")
    def play_again?, do: false
    def goodbye, do: "bye"
  end

  test "board updated when player takes turn" do
    updated_board = Board.create
                    |> TTT.update_board(players_move(6, Symbols.x))

    assert updated_board == [nil, nil, nil,
                             nil, nil, nil,
                             Symbols.x, nil, nil]
  end

  test "alternates player symbols" do
    updated_board = Board.create
                    |> TTT.update_board(players_move(6, Symbols.x))
                    |> TTT.update_board(players_move(1, Symbols.o))

    assert updated_board == [nil, Symbols.o, nil,
                             nil, nil, nil,
                             Symbols.x, nil, nil]
  end

  test "announces a win when winning move is made" do
    winning_board = [nil, Symbols.o, Symbols.x,
                    Symbols.x, Symbols.o, Symbols.o,
                    Symbols.x, Symbols.x, Symbols.o]

    console_output = capture_io(fn ->
      players_move(0, Symbols.x)
      |> TTT.play_move(PromptStub, winning_board)
    end)

    assert String.ends_with?(console_output, "Win\n")
  end

  test "announces a draw when the last move is taken" do
    drawn_board = [nil, Symbols.o, Symbols.x,
                   Symbols.o, Symbols.o, Symbols.x,
                   Symbols.x, Symbols.x, Symbols.o]

    console_output = capture_io(fn ->
      players_move(0, Symbols.x)
      |> TTT.play_move(PromptStub, drawn_board)
    end)

    assert String.ends_with?(console_output, "Draw\n")
  end

  test "displays board when playing a move" do
    winning_board = [nil, Symbols.o, Symbols.x,
                     Symbols.x, Symbols.o, Symbols.o,
                     Symbols.x, Symbols.x, Symbols.o]

    console_output = capture_io(fn ->
      players_move(0, Symbols.x)
      |> TTT.play_move(PromptStub, winning_board)
    end)

    assert console_output == "Board\nWin\n"
  end

  test "players take turn until the game is over" do
    players_input = "1\n2\n4\n3\n5\n6\n7\n"
    game_input = @dimension_choice <> @game_choice <> players_input <> @dont_play_again

    console_output = capture_io(game_input, fn -> TTT.start(InputValidatingPrompt) end)

    assert String.contains?(console_output, "[  X  ][  O  ][  O  ]\n[  X  ][  X  ][  O  ]\n[  X  ][  8  ][  9  ]")
    assert String.contains?(console_output, "X has won!")
    assert String.ends_with?(console_output, "Play again? (Y to start a new game)\n>Goodbye!\n")
  end

  test "plays two matches" do
    players_input = "1\n3\n4\n5\n7\n"
    players_second_input = "1\n2\n3\n4\n6\n5\n7\n9\n8\n"

    game_input = @dimension_choice <> @game_choice <> players_input <> @play_again <>
                 @dimension_choice <> @game_choice <> players_second_input <> @dont_play_again

    console_output = capture_io(game_input, fn -> TTT.start(InputValidatingPrompt) end)

    assert String.contains?(console_output, "X has won!")
    assert String.contains?(console_output, "It is a draw!")
  end

  def players_move(move, symbol), do: %{symbol => fn(_) -> move end}
end
