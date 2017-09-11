require "mini_maxable"

class AlphaBeta < MiniMaxable

  MAX_VALUE = 10000
  MIN_VALUE = -10000

  def initialize(board, options = {})
    @alpha = options.fetch(:alpha, MIN_VALUE)
    @beta = options.fetch(:beta, MAX_VALUE)
    super(board, options)
  end
end
