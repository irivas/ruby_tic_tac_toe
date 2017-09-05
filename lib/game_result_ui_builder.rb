require "ui_builder"
require "game_result_ui"

class GameResultUIBuilder < UIBuilder
  def build
    GameResultUI.new(board: @board, input: @input, output: @output)
  end
end
