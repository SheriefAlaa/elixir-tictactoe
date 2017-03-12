defmodule Players.PlayersTest do
  use ExUnit.Case
  alias Player.HumanPlayer
  alias Player.MinimaxPlayer
  alias Player.Minimax4x4Player
  alias Players.Players, as: Players

  test "3x3 human vs human" do
    players = GameType.human_human_id
              |> GameType.with_id
              |> Players.for_game(3)

    assert Map.get(players, PlayerSymbols.x) == &(HumanPlayer.choose_move/1)
    assert Map.get(players, PlayerSymbols.o) == &(HumanPlayer.choose_move/1)
  end

  test "3x3 human vs computer" do
    players = GameType.human_computer_id
              |> GameType.with_id
              |> Players.for_game(3)

    assert Map.get(players, PlayerSymbols.x) == &(HumanPlayer.choose_move/1)
    assert Map.get(players, PlayerSymbols.o) == &(MinimaxPlayer.choose_move/1)
  end

  test "3x3 computer vs human" do
    players = GameType.computer_human_id
              |> GameType.with_id
              |> Players.for_game(3)

    assert Map.get(players, PlayerSymbols.x) == &(MinimaxPlayer.choose_move/1)
    assert Map.get(players, PlayerSymbols.o) == &(HumanPlayer.choose_move/1)
  end

  test "3x3 computer vs computer" do
    players = GameType.computer_computer_id
              |> GameType.with_id
              |> Players.for_game(3)

    assert Map.get(players, PlayerSymbols.x) == Players.delayed_move_for(MinimaxPlayer)
    assert Map.get(players, PlayerSymbols.o) == Players.delayed_move_for(MinimaxPlayer)
  end

  test "4x4 human vs human" do
    players = GameType.human_human_id
              |> GameType.with_id
              |> Players.for_game(4)

    assert Map.get(players, PlayerSymbols.x) == &(HumanPlayer.choose_move/1)
    assert Map.get(players, PlayerSymbols.o) == &(HumanPlayer.choose_move/1)
  end

  test "4x4 human vs computer" do
    players = GameType.human_computer_id
              |> GameType.with_id
              |> Players.for_game(4)

    assert Map.get(players, PlayerSymbols.x) == &(HumanPlayer.choose_move/1)
    assert Map.get(players, PlayerSymbols.o) == &(Minimax4x4Player.choose_move/1)
  end

  test "4x4 computer vs human" do
    players = GameType.computer_human_id
              |> GameType.with_id
              |> Players.for_game(4)

    assert Map.get(players, PlayerSymbols.x) == &(Minimax4x4Player.choose_move/1)
    assert Map.get(players, PlayerSymbols.o) == &(HumanPlayer.choose_move/1)
  end

  test "4x4 computer vs computer" do
    players = GameType.computer_computer_id
              |> GameType.with_id
              |> Players.for_game(4)

    assert Map.get(players, PlayerSymbols.x) == Players.delayed_move_for(Minimax4x4Player)
    assert Map.get(players, PlayerSymbols.o) == Players.delayed_move_for(Minimax4x4Player)
  end
end
