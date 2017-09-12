require "game_result_ui_builder"
require "board"

describe GameResultUI do
  describe "#report_result" do
    it "prints board" do
      game_result_ui(o_winning_board).report_result
      formatted_board = BoardFormatter.new(o_winning_board).format
      expect(@output.string).to match(formatted_board)
    end

    it "prints X wins for X's winning baord" do
      game_result_ui(x_winning_board).report_result
      expect(@output.string).to match("X wins!")
    end

    it "prints O wins for O's winning board" do
      game_result_ui(o_winning_board).report_result
      expect(@output.string).to match("O wins!")
    end

    it "prints draw for draw board" do
      game_result_ui(drawn_board).report_result
      expect(@output.string).to match("It's a draw!\n")
    end
  end

  def game_result_ui(board)
    @input = StringIO.new
    @output = StringIO.new
    @board = board
    GameResultUIBuilder
      .new(input: @input, output: @output)
      .set_board(@board)
      .build
  end
end

