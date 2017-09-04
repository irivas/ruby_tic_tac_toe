require "board"

class Game
  attr_reader :board

  def initialize(player_x, player_o)
    @player_x = player_x
    @player_o = player_o
    @board = Board.new
  end

  def run
    unless board.complete?
      @board = @board.move(next_players_move)
      run
    end
  end

  private
  def next_players_move 
    next_player.request_move(board)
  end

  def next_player 
    @board.next_player == :x ? @player_x : @player_o
  end
end
