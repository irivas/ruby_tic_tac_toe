require "console_ui/player_ui_builder"
require "console_ui/player_ui"
require "core/board"

describe ConsoleUI::PlayerUIBuilder do
  describe "#build" do
    it "builds PlayerUI" do
      builder = ConsoleUI::PlayerUIBuilder.new
      board_ui = builder.set_board(Board.new).build
      expect(board_ui).to be_an_instance_of(ConsoleUI::PlayerUI)
    end
  end
end
