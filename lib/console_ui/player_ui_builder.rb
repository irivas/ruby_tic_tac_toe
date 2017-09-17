require "console_ui/ui_builder"
require "console_ui/player_ui"

module ConsoleUI
  class PlayerUIBuilder < ConsoleUI::UIBuilder
    def build
      PlayerUI.new(board: @board, input: @input, output: @output)
    end
  end
end
