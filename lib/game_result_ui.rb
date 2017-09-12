require "ui"

class GameResultUI < UI
  def report_result
    clear_screen
    print_board
    print_result
  end

  private
  def print_result
    @output.puts(message)
  end

  def message
    @board.winner? ? winning_message : draw_message
  end

  def winning_message
    "#{winner} wins!"
  end

  def draw_message
    "It's a draw!"
  end

  def winner
    @board.winner.upcase
  end
end
