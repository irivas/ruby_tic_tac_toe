$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib")
require "game_builder"
require "human_player"
require "computer_player"
require "player_ui_builder"
require "game_result_ui_builder"
require "board"
require "mini_max"

player_x = HumanPlayer.new(PlayerUIBuilder.new)
player_o = ComputerPlayer.new(PlayerUIBuilder.new, MiniMax, sleep_time: 1, max_depth: 4)

GameBuilder
  .new
  .add_player_x(player_x)
  .add_player_o(player_o)
  .add_board(Board.new)
  .add_result_ui_builder(GameResultUIBuilder.new)
  .build
  .run
