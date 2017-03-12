defmodule Prompt.NumberFormatter do

  def zero_based_value(value) do
    to_integer(value)
    |> decrement
  end

  def to_integer(value), do: String.to_integer(value)

  def is_integer?(value) do
    case Integer.parse(value) do
      {_number, ""} -> true
      {_, _remainder}  -> false
      :error   -> false
    end
  end

  defp decrement(move), do: move - 1
end
