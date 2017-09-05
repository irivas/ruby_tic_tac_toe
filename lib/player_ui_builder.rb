require "ui_builder"
require "player_ui"

class PlayerUIBuilder < UIBuilder
  def build
    PlayerUI.new(board: @board, input: @input, output: @output)
  end
end
