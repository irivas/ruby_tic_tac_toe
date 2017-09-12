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
    all.map { |line| line.map(&@board.method(:square_status)) }
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

  private
  def all
    rows + columns + diagonals
  end

  def rows
    (1..total_squares)
      .step(size)
      .map(&method(:row))
  end

  def row(start)
    (start...start + size).to_a
  end

  def columns
    (1..size)
      .map(&method(:column))
  end

  def column(start)
    ((start..total_squares).step(size)).to_a
  end

  def diagonals
    [diagonal_from_top_left, diagonal_from_top_right]
  end

  def diagonal_from_top_left
    (squares.step(size + 1)).to_a
  end

  def diagonal_from_top_right
    ((size...total_squares).step(size - 1)).to_a
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
end
