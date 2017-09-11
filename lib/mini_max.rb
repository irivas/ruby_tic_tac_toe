require "mini_maxable"

class MiniMax < MiniMaxable
  def execute
    @move, @score = move_scores.send(max_or_min_by, &:last)
    self
  end
end
