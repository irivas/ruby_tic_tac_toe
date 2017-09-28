require "core/alpha_beta"

module Core
  class SimpleComputerPlayer
    def initialize(options = {})
      @options = options
    end

    def type
      :computer
    end

    def get_move(board)
      AlphaBeta.new(board, @options).execute.move
    end
  end
end
