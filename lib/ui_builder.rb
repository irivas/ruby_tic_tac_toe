class UIBuilder
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def set_board(board)
    @board = board
    self
  end
end
