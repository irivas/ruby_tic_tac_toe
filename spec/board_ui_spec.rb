require "board_ui"
require "board"
require "board_formatter"

describe BoardUI do
  describe "#print_board" do
    it "prints current board state" do
      board = build_board
      board_ui = build_ui(board)
      board_ui.print_board
      expect(@output.string).to eq(BoardFormatter.new(board).format + "\n")
    end
  end

  describe "#request_move" do
    it "prints move request for X and returns player's move" do
      board_ui = build_ui(build_board, "1\n")
      expect(board_ui.request_move).to eq(1)
      expect(@output.string).to match(/X\'s move:/)
    end

    it "prints move request move request for O and returns player's move" do
      board_ui = build_ui(build_board(1), "2\n")
      expect(board_ui.request_move).to eq(2)
      expect(@output.string).to match(/O\'s move:/)
    end

    it "handles non-integer input" do
      board_ui = build_ui(build_board, "1blah\n2\n")
      expect(board_ui.request_move).to eq(2)
      expect(@output.string).to match(/Boom: invalid input/)
    end

    it "handles invalid input" do
      board_ui = build_ui(build_board(1), "1\n2\n")
      expect(board_ui.request_move).to eq(2)
      expect(@output.string).to match(/Boom: invalid input/)
    end
  end
end

def build_ui(board, input = "")
  @input = StringIO.new(input)
  @output = StringIO.new
  BoardUI.new(board, input: @input, output: @output)
end
