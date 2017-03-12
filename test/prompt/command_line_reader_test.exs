defmodule Prompt.CommandLineReaderTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias Prompt.CommandLineReader, as: CommandLineReader

  test "read users input from the command line" do
    capture_io("1\n",
    fn ->
      input = CommandLineReader.read
      assert input == "1"
    end)
  end
end
