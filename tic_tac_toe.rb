$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib")
require "game_builder"
require "player"
require "player_ui_builder"
require "game_result_ui_builder"
require "board"

player_x = Player.new(PlayerUIBuilder.new)
player_o = Player.new(PlayerUIBuilder.new)

GameBuilder
  .new
  .add_player_x(player_x)
  .add_player_o(player_o)
  .add_board(Board.new)
  .add_result_ui_builder(GameResultUIBuilder.new)
  .build
  .run
