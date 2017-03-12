defimpl Player, for: HumanPlayer do
  alias Prompt.InputValidatingPrompt

  def choose_move(board) do
    InputValidatingPrompt.get_valid_move(board)
  end
end
