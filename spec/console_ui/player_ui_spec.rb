require "console_ui/player_ui_builder"
require "console_ui/board_formatter"
require "core/board"

describe ConsoleUI::PlayerUI do
  describe "#request_move" do
    it "sends 'clear' call to system" do
      player_ui = build_ui(build_board, "1\n")
      expect(player_ui).to receive(:system).with("clear")
      player_ui.request_move
    end

    it "prints current board state" do
      board = build_board
      formatted_board = ConsoleUI::BoardFormatter.new(board).format
      build_ui(board, "1\n").request_move
      expect(@output.string).to match(formatted_board)
    end

    it "prints move request for X and returns player's move" do
      player_ui = build_ui(build_board, "1\n")
      expect(player_ui.request_move).to eq(1)
      expect(@output.string).to match(/X\'s move:/)
    end

    it "prints move request move request for O and returns player's move" do
      player_ui = build_ui(build_board(1), "2\n")
      expect(player_ui.request_move).to eq(2)
      expect(@output.string).to match(/O\'s move:/)
    end

    it "handles non-integer input" do
      player_ui = build_ui(build_board, "1blah\n2\n")
      expect(player_ui.request_move).to eq(2)
      expect(@output.string).to match(/Boom: invalid input/)
    end

    it "handles invalid input" do
      player_ui = build_ui(build_board(1), "1\n2\n")
      expect(player_ui.request_move).to eq(2)
      expect(@output.string).to match(/Boom: invalid input/)
    end
  end
end

def build_ui(board, input = "")
  @input = StringIO.new(input)
  @output = StringIO.new
  ConsoleUI::PlayerUIBuilder
    .new(input: @input, output: @output)
    .set_board(board)
    .build
end
