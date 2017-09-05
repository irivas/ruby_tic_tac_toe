require "board"

class Game
  def initialize(player_x:, player_o:, board:, result_ui_builder:)
    @player_x = player_x
    @player_o = player_o
    @board = board
    @result_ui_builder = result_ui_builder
  end

  def run
    if @board.complete?
      report_game_complete
    else
      request_next_players_move
    end
  end

  private
  def report_game_complete
    @result_ui_builder
      .set_board(@board)
      .build
      .report_result
  end

  def request_next_players_move
      @board = @board.move(next_players_move)
      run
  end

  def next_players_move 
    next_player.request_move(@board)
  end

  def next_player 
    @board.next_player == :x ? @player_x : @player_o
  end
end
