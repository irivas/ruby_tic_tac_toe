require "core/computer_player"
require "core/mini_max"
require "console_ui/player_ui_builder"
require "console_ui/board_formatter"

describe ComputerPlayer do
  describe "#request_move" do
    it "gets move from provided algorithm and returns player's move" do
      board = build_board(1, 4, 2, 5)
      player = ComputerPlayer.new(ui_builder, MiniMax)
      board_output = ConsoleUI::BoardFormatter.new(board).format

      expect(player.request_move(board)).to eq(3)
      expect(@output.string).to match(board_output)
    end
  end

  def ui_builder(input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    ConsoleUI::PlayerUIBuilder.new(input: @input, output: @output)
  end
end

