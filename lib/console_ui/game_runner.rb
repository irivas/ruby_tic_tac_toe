require "console_ui/ui"
require "console_ui/game_options_ui"
require "console_ui/player_ui_builder"
require "console_ui/game_result_ui_builder"
require "console_ui/game_over_ui"
require "core/game_options"
require "console_ui/game_builder"
require "core/board"
require "core/human_player"
require "core/computer_player"
require "core/alpha_beta"
require "console_ui/game_instance_runner"

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
      GameOptions.new(game_options_ui).run
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

    def player(player_type)
      player_type == :human ? human_player : computer_player
    end

    def human_player
      HumanPlayer.new(player_ui_builder)
    end

    def computer_player
      ComputerPlayer.new(player_ui_builder, AlphaBeta, sleep_time: 0.5, max_depth: 4)
    end

    def player_ui_builder
      ConsoleUI::PlayerUIBuilder.new(input: @input, output: @output)
    end

    def game_result_ui_builder
      ConsoleUI::GameResultUIBuilder.new(input: @input, output: @output)
    end
  end
end
