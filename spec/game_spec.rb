require "game_builder"
require "game"
require "player"
require "player_ui_builder"
require "board"
require "game_result_ui_builder"

describe Game do
  describe "#run" do
    it "plays game until complete" do
      player_x = build_player("1\n2\n3\n")
      player_o = build_player("4\n5\n")
      formatted_final_board = BoardFormatter.new(build_board(1, 4, 2, 5, 3)).format

      game = GameBuilder
        .new
        .add_player_x(player_x)
        .add_player_o(player_o)
        .add_board(Board.new)
        .add_result_ui_builder(game_result_ui_builder)
        .build

      game.run

      expect(@result_output.string).to match(formatted_final_board)
    end
  end

  def game_result_ui_builder(input = "")
    @result_output = StringIO.new
    GameResultUIBuilder.new(input: StringIO.new(input), output: @result_output)
  end

  def build_player(input)
    ui_builder = PlayerUIBuilder.new(input: StringIO.new(input), output: StringIO.new)
    Player.new(ui_builder)
  end
end
