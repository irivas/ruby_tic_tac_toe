require "core/human_player"
require "core/computer_player"
require "core/alpha_beta"
require "rack_app/player_ui_builder"
require "rack_app/game_result_ui"

module RackApp
  class Game
    
    attr_reader :board

    def initialize(options)
      moves = options[:moves]
      move = options[:move]
      is_active_game = options[:is_active_game]

      @board = is_active_game ? build_board(moves, move) : Board.new
      @player_type = options.fetch("player_#{@board.next_player}_type".to_sym, :human)
      @player_options = {
        player_x_type: options.fetch(:player_x_type, :human),
        player_o_type: options.fetch(:player_o_type, :human)
      }
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
      next_player.request_move(@board)
    end

    def next_player 
      @player_type == :human ? 
        HumanPlayer.new(RackApp::PlayerUIBuilder.new) : 
        ComputerPlayer.new(RackApp::PlayerUIBuilder.new, AlphaBeta, @player_options) 
    end
  end
end
