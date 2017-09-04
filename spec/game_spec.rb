require "game"
require "player"
require "player_ui_builder"
require "board"

describe Game do
  describe "#run" do
    it "plays game until complete" do
      player_x = build_player("1\n2\n3\n")
      player_o = build_player("4\n5\n")
      game = Game.new(player_x, player_o)
      game.run
      expect(game.board).to eq(build_board(1, 4, 2, 5, 3))
    end
  end
end

def build_player(input)
  ui_builder = PlayerUIBuilder.new(input: StringIO.new(input), output: StringIO.new)
  Player.new(ui_builder)
end
