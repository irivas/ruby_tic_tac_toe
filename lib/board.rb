require "lines"

class Board
  def initialize(moves = [])
    @moves = moves
    @lines = Lines.new(self)
  end

  def moves
    @moves
  end

  def move(square)
     valid_move?(square) ? Board.new(moves + [square]) : self
  end

  def valid_move?(square)
    square_in_bounds?(square) && square_empty?(square)
  end

  def square_status(square)
    square_mark(square) || :empty
  end

  def winner?
    @lines.winner?
  end

  def winner
    @lines.winner
  end

  def squares
    (1..total_squares)
  end

  def total_squares
    size ** 2
  end

  def size
    3
  end

  def rows_as_square_numbers_and_statuses
    @lines.rows_as_square_numbers_and_statuses
  end

  private
  def square_empty?(square)
    !moves.include?(square)
  end

  def square_mark(square)
    if is_square_marked(square, :x)
      :x
    elsif is_square_marked(square, :o)
      :o
    end
  end

  def is_square_marked(square, mark)
    player_moves(mark).include?(square)
  end

  def square_in_bounds?(square)
    squares.include?(square)
  end

  def player_moves(player_mark)
    move_selector = player_mark == :x ? :even? : :odd?
    select_moves { |i| i.send(move_selector) }
  end

  def select_moves(&index_selector)
    move_indexes = moves.each_index.select(&index_selector)
    moves.values_at(*move_indexes)
  end
end
