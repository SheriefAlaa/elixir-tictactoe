# Tic-Tac-Toe

Tic-Tac-Toe is a game where players take turn in marking the cells in a 3x3 (or 4x4) grid. The player who succeeds in placing three (or four) respective marks in a horizontal, vertical or diagonal row wins the game.

# The Solution
This solution is written in [Elixir](http://elixir-lang.org/).


# Running the application
- Install Elixir:
Follow the instructions [here]( http://elixir-lang.org/install.html)

- Clone the repository
```
git clone git@github.com:gemcfadyen/elixir-tictactoe.git
```
- Navigate to root directory
```
cd elixir-tictactoe/ttt
```
- Compile the code
```
mix compile
```
- Run the application
```
mix run -e TTT.start
```
- Run all tests
```
mix test
```
- Run tests for individual module
```
mix test test/<test_file_name>.exs
```
- Run specific test case
```
mix test test/<test_file_name>.exs:<line_number>
```

# Playing Tic-Tac-Toe
When prompted, enter 3 or 4 to choose the dimension of the grid you wish to use.

When prompted, select which game type you would like.

Human vs Human, Human vs Computer, Computer vs Human and Computer vs Computer are supported.

When playing, enter your move through the command line. You will be reprompted if the move entered is invalid.

To play again, enter y or Y when prompted.

Good Luck!

