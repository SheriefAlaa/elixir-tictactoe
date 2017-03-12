defmodule PlayerSymbols do
  @valid_symbols  [:X, :O]

  def x, do: List.first(@valid_symbols)
  def o, do: List.last(@valid_symbols)

  def valid_symbol?(value), do: Enum.member?(@valid_symbols, value)
end
