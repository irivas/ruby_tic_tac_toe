$LOAD_PATH.unshift(File.dirname(__FILE__))
require "game"
require "player"
require "player_ui_builder"

player_x = Player.new(PlayerUIBuilder.new)
player_o = Player.new(PlayerUIBuilder.new)

Game.new(player_x, player_o).run
