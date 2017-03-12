defmodule GameBoard.Board do

  def create(dimension \\ 3) do
    Enum.map(1..dimension * dimension, fn(_) -> nil end)
    |> Enum.to_list
  end

  def update(board, index, player_symbol) do
    List.update_at(board, index, fn(_) -> player_symbol end)
  end

  def symbol_at(board, index), do: Enum.at(board, index)

  def free_spaces?(board) do
    Enum.map(board, &occupied_space?(&1))
    |> Enum.any?(&(&1 == false))
  end

  def indicies_of_free_spaces(board) do
    Enum.with_index(board)
    |> Enum.map(fn{cell, index} -> index_of_free(cell, index) end)
    |> Enum.filter(&(is_number(&1)))
  end

  def free_space_at?(index, board) do
    indicies_of_free_spaces(board)
    |> Enum.member?(index)
  end

  def winning_line?(board) do
    winning_row?(board)
    or winning_column?(board)
    or winning_diagonal?(board)
  end

  def winning_symbol(board) do
    cond do
      winning_row?(board) -> rows(board) |> find_winning_symbol
      winning_column?(board) -> columns(board) |> rows |> find_winning_symbol
      winning_diagonal?(board) -> diagonals(board) |> rows |> find_winning_symbol
      true -> nil
    end
  end

  def dimension(board) do
    Enum.count(board)
    |> :math.sqrt
    |> round
  end

  defp occupied_space?(cell), do: PlayerSymbols.valid_symbol?(cell)

  defp index_of_free(cell, index) do
    if is_nil(cell), do: index, else: cell
  end

  defp winning_row?(board) do
   rows(board)
   |> Enum.map(&all_cells_match?(&1))
   |> Enum.any?(&(&1 == true))
  end

  defp rows(board), do: Enum.chunk(board, dimension(board))

  defp columns(board) do
    horizontal_rows = rows(board)
    _columns(horizontal_rows, [], Enum.count(horizontal_rows))
  end
  defp _columns(_,acc, 0), do: acc
  defp _columns(rows, column_accumlator, number_rows) do
    _columns(rows, form_column(rows, column_accumlator, number_rows), decrement(number_rows))
  end

  defp form_column(rows, accumulator, number_rows) do
    accumulator ++ get_symbol_at_index_from(rows, decrement(number_rows))
  end

  defp decrement(value), do: value - 1

  defp get_symbol_at_index_from(rows, index) do
    Enum.map(rows, &(symbol_at(&1, index)))
  end

  defp diagonals(board) do
      dimension(board)
      |> - 2
      |> padding_rows(dimension(board), first_diagonal(board) ++ second_diagonal(board))
  end

  defp padding_rows(0, _, acc), do: acc
  defp padding_rows(num_rows, dimension, acc) do
    num_rows - 1
    |> padding_rows(dimension, acc ++ List.duplicate(nil, dimension))
  end

  defp first_diagonal(board) do
    _first_diagonal(board, [], dimension(board) * decrement(dimension(board)))
  end
  def _first_diagonal(_, acc, 0), do: acc
  def _first_diagonal(board, acc, index) do
    offset = dimension(board)
              |> decrement

    _first_diagonal(board, create_diagonal(board, acc, index), index - offset)
  end

  defp create_diagonal(board, accumulator, index) do
    accumulator ++ [symbol_at(board, index)]
  end

  defp second_diagonal(board) do
    dimension = dimension(board)
    _second_diagonal(board, [], dimension, dimension * dimension)
  end
  defp _second_diagonal(_, acc, 0, _), do: acc
  defp _second_diagonal(board, acc, num_rows, index) do
    offset = decrement(index) - dimension(board)
    _second_diagonal(board, create_diagonal(board, acc, decrement(index)), decrement(num_rows), offset)
  end

  defp winning_column?(board), do: winning_row?(columns(board))

  defp winning_diagonal?(board), do: winning_row?(diagonals(board))

  defp all_cells_match?([head|tail]), do: all_cells_match?(head, tail)
  defp all_cells_match?(first_symbol, tail) do
    Enum.all?(tail, &(!is_nil(first_symbol) and &1 == first_symbol))
  end

  defp find_winning_symbol(chunked_board) do
    Enum.map(chunked_board, &(get_matching_symbol_in(&1)))
    |> Enum.filter(&(!is_nil(&1)))
    |> List.first
  end

  defp get_matching_symbol_in([head|tail]) do
    if all_cells_match?(head, tail), do: head, else: nil
  end
end
