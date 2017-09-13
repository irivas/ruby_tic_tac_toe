require "console_ui/ui_builder"
require "console_ui/player_ui"

class PlayerUIBuilder < UIBuilder
  def build
    PlayerUI.new(board: @board, input: @input, output: @output)
  end
end
