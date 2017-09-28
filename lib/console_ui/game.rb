require "core/board"

module ConsoleUI
  class Game
    def initialize(player_x:, player_o:, board:, result_ui_builder:)
      @player_x = player_x
      @player_o = player_o
      @board = board
      @result_ui_builder = result_ui_builder
      setup_players
    end

    def run
      if @board.complete?
        report_game_complete
      else
        next_player.request_move(@board)
      end
    end

    private

    def setup_players
      move_reporter = lambda(&method(:update_board))
      @player_x.add_move_reporter(move_reporter)
      @player_o.add_move_reporter(move_reporter)
    end

    def update_board(move)
      @board = @board.move(move)
      run
    end

    def report_game_complete
      @result_ui_builder
        .set_board(@board)
        .build
        .report_result
    end

    def next_player 
      @board.next_player == :x ? @player_x : @player_o
    end
  end
end
