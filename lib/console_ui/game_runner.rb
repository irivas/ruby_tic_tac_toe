require "console_ui/ui"
require "console_ui/game_options_ui"
require "console_ui/game_over_ui"
require "console_ui/game_options"
require "console_ui/game_instance_runner"
require "matts_tictactoe_core"

module ConsoleUI
  class GameRunner < ConsoleUI::UI
    def run
      game(game_options)
      GameRunner.new.run if play_again?
    end

    private
    
    def play_again?
      ConsoleUI::GameOverUI.new(input: @input, output: @output).request_play_again
    end

    def game_options
      ConsoleUI::GameOptions.new(game_options_ui).run
    end

    def game_options_ui
      ConsoleUI::GameOptionsUI.new(input: @input, output: @output)
    end

    def game(options)
      game_instance_runner = build_game_instance_runner(options)
      loop do
        is_game_over = game_instance_runner.next
        if is_game_over
          game_instance_runner.report_result
          break
        end
      end
    end

    def build_game_instance_runner(game_options)
      ConsoleUI::GameInstanceRunner.new(
        input: @input, 
        output: @output,
        player_x_type: game_options.player_x_type,
        player_o_type: game_options.player_o_type)
    end
  end
end
