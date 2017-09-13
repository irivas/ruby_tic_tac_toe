require "ui"
require "game_options_ui"
require "player_ui_builder"
require "game_result_ui_builder"
require "game_options"
require "game_builder"
require "board"
require "human_player"
require "computer_player"
require "alpha_beta"
require "game_over_ui"

class GameRunner < UI
  def run
    game(game_options).run
    GameRunner.new.run if play_again?
  end

  private
  
  def play_again?
    GameOverUI.new(input: @input, output: @output).request_play_again
  end

  def game_options
    GameOptions.new(game_options_ui).run
  end

  def game_options_ui
    GameOptionsUI.new(input: @input, output: @output)
  end

  def game(options)
    GameBuilder
      .new
      .add_player_x(player(options.player_x))
      .add_player_o(player(options.player_o))
      .add_board(Board.new)
      .add_result_ui_builder(game_result_ui_builder)
      .build
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
    PlayerUIBuilder.new(input: @input, output: @output)
  end

  def game_result_ui_builder
    GameResultUIBuilder.new(input: @input, output: @output)
  end
end
