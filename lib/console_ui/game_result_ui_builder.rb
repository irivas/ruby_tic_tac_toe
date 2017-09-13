require "console_ui/ui_builder"
require "console_ui/game_result_ui"

class GameResultUIBuilder < UIBuilder
  def build
    GameResultUI.new(board: @board, input: @input, output: @output)
  end
end
