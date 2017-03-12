defmodule PlayerSymbolsTest do
  use ExUnit.Case

  test "contains X" do
    assert PlayerSymbols.x == :X
  end

  test "contains O" do
    assert PlayerSymbols.o == :O
  end

  test "X is valid" do
    assert PlayerSymbols.valid_symbol?(:X)
  end

  test "O is valid" do
    assert PlayerSymbols.valid_symbol?(:O)
  end

  test "A is not valid" do
    assert PlayerSymbols.valid_symbol?(:A) == false
  end
end
