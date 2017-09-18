require "rack_app/player_ui"

module RackApp
  class PlayerUIBuilder
    def set_board(board)
      @board = board
      self
    end

    def build
      RackApp::PlayerUI.new(@board)
    end
  end
end
