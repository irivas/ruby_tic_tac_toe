require "core/human_player"
require "rack_app/player_ui_builder"
require "rack_app/game_result_ui"

module RackApp
  class Game
    
    attr_reader :board

    def initialize(moves: nil, move: nil, is_active_game:)
      @board = is_active_game ? build_board(moves, move) : Board.new
      @player = HumanPlayer.new(RackApp::PlayerUIBuilder.new)
    end

    def run
      @board.complete? ? report_game_result : request_player_move
    end

    private

    def build_board(moves, move)
      Board.new(moves).move(move)
    end

    def report_game_result
      RackApp::GameResultUI.new(board).report_result
    end

    def request_player_move
      @player.request_move(@board)
    end
  end
end
