defmodule Prompt.CommandLineReader do
  @console_prompt ">"

  def console_prompt, do: @console_prompt

  def read do
    IO.gets(console_prompt)
    |> String.strip
  end
end
