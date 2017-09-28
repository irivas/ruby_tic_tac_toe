require "matts_tictactoe_core"
require "rack"
require "rack_app/game_ui"
require "rack_app/game_result_ui"

module RackApp
  class GameHandler

    attr_reader :path, :request_methods

    def initialize(options)
      @path = options[:path]
      @request_methods = options[:request_methods]
    end

    def handler(request)
      game = build_game(request.params)
      build_response(game)
    end

    private

    def build_game(params)
      MattsTictactoeCore::Game.new(
        player_x_type: get_player_type(:x, params),
        player_o_type: get_player_type(:o, params),
        board: get_board(params))
    end

    def get_board(params)
      moves = get_moves(params)
      move = get_move(params)
      board = MattsTictactoeCore::Board.new(moves)
      active_game?(params) ? board.move(move) : board
    end

    def active_game?(params)
      params.has_key?("move")
    end

    def get_moves(params)
      params.fetch("moves", "").split(",").map(&:to_i)
    end

    def get_move(params)
      params["move"].to_i
    end

    def get_player_type(player, params)
      params.fetch("player_#{player}_type", "human").to_sym
    end

    def build_response(game)
      game.complete? ? build_game_result_ui(game) : build_game_ui(game)
    end

    def build_game_ui(game)
      RackApp::GameUI.new(game).build
    end

    def build_game_result_ui(game)
      RackApp::GameResultUI.new(game.board).build
    end
  end
end
