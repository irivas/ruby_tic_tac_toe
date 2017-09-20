require "console_ui/game_runner"
require "console_ui/board_formatter"

describe ConsoleUI::GameRunner do
  context "Human vs Human Game" do
    it "plays game and reports X Wins" do
      game_type = 1
      moves = [1, 4, 2, 5, 3]
      play_again = "no"
      instructions = [game_type, *moves, play_again].join("\n") + "\n"
      game_runner, output = build_game_runner(instructions)
      game_runner.run

      expect(output.string).to include("X wins!")
      expect(output.string).to include(
        ConsoleUI::BoardFormatter.new(build_board(*moves)).format)
    end
  end

  def build_game_runner(input)
    output = StringIO.new
    game_runner = ConsoleUI::GameRunner.new(input: StringIO.new(input), output: output)
    [game_runner, output]
  end
end
