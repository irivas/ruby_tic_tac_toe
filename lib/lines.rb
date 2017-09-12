class Lines 
  def initialize(board)
    @board = board
  end

  def statuses 
    as_square_statuses.map do |line|
      next :x if line_of?(line, :x)
      next :o if line_of?(line, :o)
      :none
    end
  end

  def line_of?(line, status)
    line.all? { |square_status| square_status == status }
  end

  def as_square_statuses
    as_square_numbers.map { |line| line.map(&@board.method(:square_status)) }
  end

  def winner?
    winner != nil
  end

  def winner
    statuses.find { |status| status != :none }
  end

  def rows_as_square_numbers_and_statuses
    rows.map do |line| 
      line.map { |square_number| [square_number, @board.square_status(square_number)] } 
    end
  end

  def as_square_numbers 
    lines
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
    squares.to_a
  end
end
