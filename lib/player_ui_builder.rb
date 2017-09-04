require "player_ui"

class PlayerUIBuilder
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def set_board(board)
    @board = board
    self
  end

  def build
    PlayerUI.new(@board, input: @input, output: @output)
  end
end
