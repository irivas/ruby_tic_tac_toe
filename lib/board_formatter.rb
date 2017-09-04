class BoardFormatter
  def initialize(board)
    @board = board
  end

  def format
    interleave(formatted_rows, row_dividers).join("\n")
  end

  private
  def formatted_rows
    @board.rows_as_square_numbers_and_statuses.map(&method(:format_row))
  end

  def format_row(row)
    (row.map { |square| " #{format_square(square)} " }).join("|")
  end

  def format_square(square)
    number, status = square
    status == :empty ? number : status.upcase
  end

  def row_dividers
    ["___________"] * (@board.size - 1)
  end

  def interleave(arr1, arr2)
    arr1.zip(arr2).flatten.compact
  end
end
