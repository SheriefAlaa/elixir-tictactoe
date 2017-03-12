defmodule Prompt.BoardPresenter do
  alias Prompt.ConsoleCleaner

  def display(formatted_board) do
    ConsoleCleaner.refresh
    draw_board(formatted_board)
  end

  defp draw_board(formatted_board) do
    Enum.map(formatted_board, &(display_row(&1)))
  end

  defp display_row(row) do
    List.foldl(row, "", fn(cell, acc) -> acc <> format(cell) end)
    |> IO.puts
  end

  defp format(cell) do
      if needs_padding?(cell), do: "[  #{cell}  ]", else: "[  #{cell} ]"
  end

  defp needs_padding?(cell) do
    single_digit?(cell) or occupied?(cell)
  end

  defp single_digit?(cell), do: cell < 10

  defp occupied?(cell), do: PlayerSymbols.valid_symbol?(cell)
end
