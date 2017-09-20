require "rack_app/player_ui"

module RackApp
  class PlayerUIBuilder
    def set_board(board)
      @board = board
      self
    end

    def set_options(options)
      @options = options
      self
    end

    def build
      RackApp::PlayerUI.new(@board, @options)
    end
  end
end
