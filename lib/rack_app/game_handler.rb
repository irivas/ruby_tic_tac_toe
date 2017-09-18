require "rack"
require "core/board"
require "rack_app/player_ui"

module RackApp
  class GameHandler

    attr_reader :path, :request_methods

    def initialize(options)
      @path = options[:path]
      @request_methods = options[:request_methods]
    end

    def handler(request)
      unless active_game?(request.params)
        board = Board.new 
      else
        board = Board.new(get_moves(request.params))
                     .move(get_move(request.params))
      end
      RackApp::PlayerUI.new(board).request_move
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
  end
end
