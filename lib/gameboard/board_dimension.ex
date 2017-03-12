defmodule GameBoard.BoardDimension do
  @valid_dimensions [3, 4]

  def dimension_3, do: List.first(@valid_dimensions)
  def dimension_4, do: List.last(@valid_dimensions)

  def for_display, do: Enum.join(@valid_dimensions, " or ")
  def valid_dimension?(input), do: Enum.member?(@valid_dimensions, input)
end
