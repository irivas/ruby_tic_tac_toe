require "human_player"
require "player_ui_builder"
require "board"
require "board_formatter"

describe HumanPlayer do
  describe "#request_move" do
    it "requests move through provided ui and returns player's move" do
      ui_builder = build_player_ui_builder("1\n")
      player = HumanPlayer.new(ui_builder)
      board_output = BoardFormatter.new(build_board(1)).format

      expect(player.request_move(build_board)).to eq(1)
      expect(@output.string).to match(board_output)
    end
  end

  def build_player_ui_builder(input = "")
    @input = StringIO.new(input)
    @output = StringIO.new
    PlayerUIBuilder.new(input: @input, output: @output)
  end
end

