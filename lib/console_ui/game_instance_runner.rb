require "core/game"
require "console_ui/game_ui"
require "console_ui/game_result_ui"

module ConsoleUI
  class GameInstanceRunner
    attr_reader :game
    
    def initialize(options)
      @output = options[:output]
      @input = options[:input]
      @game = build_game(options)
      @game_ui = build_game_ui(options, game)
    end

    def next
      game.next_move(@game_ui.next_move)
      return game.complete?
    end

    def report_result
      build_game_result_ui.render
    end

    private

    def build_game(options)
      Core::Game.new(
        player_x_type: options[:player_x_type], 
        player_o_type: options[:player_o_type])
    end

    def build_game_ui(options, game)
      ConsoleUI::GameUI.new(
        input: @input, output: @output, game: @game)
    end

    def build_game_result_ui
      ConsoleUI::GameResultUI.new(game: game, output: @output)
    end
  end
end
