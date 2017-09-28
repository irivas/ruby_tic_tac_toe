module ConsoleUI
  class UIBuilder
    def initialize(options = {})
      @input = options.fetch(:input, $stdin);
      @output = options.fetch(:output, $stdout);
    end

    def set_board(board)
      @board = board
      self
    end
  end
end
