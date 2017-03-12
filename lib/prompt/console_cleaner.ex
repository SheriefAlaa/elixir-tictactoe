defmodule Prompt.ConsoleCleaner do
  alias IO.ANSI, as: ANSI

  def refresh do
    clear_console
    position_cursor_at_top
  end

  defp clear_console do
    ANSI.clear
    |> IO.puts
  end

  defp position_cursor_at_top do
    ANSI.home
    |> IO.puts
  end
end
