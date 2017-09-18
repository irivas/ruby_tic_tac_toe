require "rack"
require "core/board"
require "rack_app/player_ui"
require "rack_app/game"

module RackApp
  class GameHandler

    attr_reader :path, :request_methods

    def initialize(options)
      @path = options[:path]
      @request_methods = options[:request_methods]
    end

    def handler(request)
      build_game(request.params).run
    end

    private

    def build_game(params)
      RackApp::Game.new(
        moves: get_moves(params), 
        move: get_move(params), 
        is_active_game: active_game?(params))
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
