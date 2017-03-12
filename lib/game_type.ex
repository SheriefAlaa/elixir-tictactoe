defmodule GameType do
  @human_human_id 1
  @human_computer_id 2
  @computer_human_id 3
  @computer_computer_id 4

  @human_vs_human "Human vs Human"
  @human_vs_computer "Human vs Computer"
  @computer_vs_human "Computer vs Human"
  @computer_vs_computer "Computer vs Computer"

  @player_types %{@human_human_id => @human_vs_human,
                  @human_computer_id => @human_vs_computer,
                  @computer_human_id => @computer_vs_human,
                  @computer_computer_id => @computer_vs_computer}

  def human_human_id, do: @human_human_id
  def human_computer_id, do: @human_computer_id
  def computer_human_id, do: @computer_human_id
  def computer_computer_id, do: @computer_computer_id
  def human_vs_human, do: @human_vs_human
  def human_vs_computer, do: @human_vs_computer
  def computer_vs_human, do: @computer_vs_human
  def computer_vs_computer, do: @computer_vs_computer

  def with_id(type_id) do
    Map.fetch(@player_types, type_id)
    |> id
  end

  def for_display do
    Enum.map(@player_types, format_game_type)
    |> Enum.reduce(format)
  end

  def is_valid?(id), do: Enum.member?(valid_ids, id)

  defp valid_ids, do: Map.keys(@player_types)

  defp id({:ok, game_type}), do: game_type

  defp format_game_type do
    fn{type_id, game_type} -> "(#{type_id}) #{game_type}" end
  end

  defp format do
    fn(player_type, acc) -> acc <> "\n" <> player_type end
  end
end
