require "console_ui/game_runner"

describe ConsoleUI::GameRunner do
  describe "#run" do
    it "runs a game" do
      instructions = "1\n1\n4\n2\n5\n3\nn\n"
      game_runner(instructions).run
      expect(@output.string).to match(/X wins!/)
    end

    def game_runner(input)
      @output = StringIO.new
      ConsoleUI::GameRunner.new(input: StringIO.new(input), output: @output)
    end
  end
end
