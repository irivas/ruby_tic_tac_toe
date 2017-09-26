require "console_ui/ui_builder"
require "console_ui/game_result_ui"

module ConsoleUI
  class GameResultUIBuilder < ConsoleUI::UIBuilder
    def build
      ConsoleUI::GameResultUI.new(board: @board, input: @input, output: @output)
    end
  end
end
