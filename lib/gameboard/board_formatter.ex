defmodule GameBoard.BoardFormatter do
  alias GameBoard.Board

  def format(board) do
    Enum.with_index(board)
    |> Enum.map(fn {cell, index} -> format_to_one_indexed(cell, index) end)
    |> Enum.chunk(dimension(board))
  end

  defp format_to_one_indexed(cell, index) do
    if is_nil(cell), do: index + 1, else: cell
  end

  defp dimension(board), do: Board.dimension(board)
end
