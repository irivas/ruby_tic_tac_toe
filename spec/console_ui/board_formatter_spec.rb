require "console_ui/board_formatter"
require "matts_tictactoe_core"

describe ConsoleUI::BoardFormatter do
  describe "#format" do
    it "formats empty board" do
      expect(ConsoleUI::BoardFormatter.new(build_board).format).to eq([
        " 1 | 2 | 3 ",
        "___________",
        " 4 | 5 | 6 ",
        "___________",
        " 7 | 8 | 9 "].join("\n"))
    end

    it "formats partially complete board" do
      expect(ConsoleUI::BoardFormatter.new(build_board(1, 2, 5, 9)).format).to eq([
        " X | O | 3 ",
        "___________",
        " 4 | X | 6 ",
        "___________",
        " 7 | 8 | O "].join("\n"))
    end
  end
end
