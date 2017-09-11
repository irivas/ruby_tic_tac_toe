require "mini_maxable"

class AlphaBeta < MiniMaxable

  MAX_VALUE = 10000
  MIN_VALUE = -10000

  def execute
    possible_moves.each do |move|
      score = move_score(move)
      update_move_and_score!(move, score) if better_score?(score)
      break if (@beta <= @alpha)
    end

    self
  end

  private
  def setup(options)
    @alpha = options.fetch(:alpha, MIN_VALUE)
    @beta = options.fetch(:beta, MAX_VALUE)
  end

  def better_score?(score)
    @is_maximising ? (score > @alpha) : (score < @beta)
  end

  def update_move_and_score!(move, score)
    if @is_maximising
      @alpha = score
    else
      @beta = score
    end

    @move = move
    @score = score
  end
end
