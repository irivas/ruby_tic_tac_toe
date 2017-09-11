require "mini_maxable"

class MiniMax < MiniMaxable
  def execute
    @move, @score = move_scores.send(max_or_min_by, &:last)
    self
  end

  private
  def move_scores
    possible_moves.map { |move| [move, move_score(move)] }
  end

  def max_or_min_by
    @is_maximising ? :max_by : :min_by
  end
end
