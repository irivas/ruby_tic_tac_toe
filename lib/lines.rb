require "line"

class Lines 
  def initialize(board)
    @board = board
  end

  def statuses 
    lines.map(&:status)
  end

  def as_square_numbers
    lines.map(&:as_square_numbers)
  end

  def as_square_statuses
    lines.map(&:as_square_statuses)
  end
  
  def winner?
    winner != nil
  end

  def winner
    statuses.find { |status| status != :none }
  end

  def rows_as_square_numbers_and_statuses
    rows.map(&:as_square_numbers_and_statuses)
  end

  private
  def lines
    rows + columns + diagonals
  end

  def rows
    (1..total_squares)
      .step(size)
      .map(&method(:row))
      .to_a
  end

  def row(start)
    new_line((start...start + size))
  end

  def columns
    (1..size)
      .map(&method(:column))
      .to_a
  end

  def column(start)
    new_line((start..total_squares).step(size))
  end

  def diagonals
    [diagonal_from_top_left, diagonal_from_top_right]
  end

  def diagonal_from_top_left
    new_line(squares.step(size + 1))
  end

  def diagonal_from_top_right
    new_line((size...total_squares).step(size - 1))
  end

  def size
    @board.size
  end

  def total_squares
    @board.total_squares
  end

  def squares
    @board.squares
  end

  def new_line(squares)
    Line.new(@board, squares)
  end
end
