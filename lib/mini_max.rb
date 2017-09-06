class MiniMax

  BASE_WINNING_SCORE = 10
  DRAWING_SCORE = 0

  attr_reader :move, :score

  def initialize(initial_board, depth: 0, is_maximising: true)
    @initial_board = initial_board
    @depth = depth
    @is_maximising = is_maximising
  end

  def execute
    @move, @score = move_scores.send(max_or_min) { |result| result.last }
    self
  end

  private
  def move_scores
    possible_moves.map { |move| [move, move_score(move)] }
  end

  def possible_moves
    @initial_board.empty_squares
  end

  def move_score(move)
    board_score(@initial_board.move(move))
  end

  def max_or_min
    @is_maximising ? :max_by : :min_by
  end

  def board_score(board)
    board.complete? ? final_score(board) : recursive_score(board)
  end

  def final_score(board)
    winning_move(board) ? winning_score : drawing_score
  end

  def winning_move(board)
    board.winner? && next_player_wins?(board)
  end

  def next_player_wins?(board)
    board.winner == @initial_board.next_player
  end

  def winning_score
    (BASE_WINNING_SCORE * mini_max_multiplier) - depth_offset
  end

  def mini_max_multiplier 
    @is_maximising ? 1 : -1
  end

  def depth_offset
    @is_maximising ? @depth : -@depth
  end

  def drawing_score
    DRAWING_SCORE
  end

  def recursive_score(board)
    MiniMax.new(board, recursive_options).execute.score
  end

  def recursive_options
    { depth: @depth + 1, is_maximising: !@is_maximising }
  end
end
