class Line
  def initialize(game, squares)
    @game = game
    @squares = squares
  end

  def as_square_numbers_and_statuses
    as_square_numbers.zip(as_square_statuses)
  end

  def as_square_numbers
    @squares.to_a
  end

  def as_square_statuses 
    @squares.map { |square| @game.square_status(square) }
  end

  def status
    if of?(:x)
      :x
    elsif of?(:o)
      :o
    else
      :none
    end
  end

  private
  def of?(mark)
    as_square_statuses.all? { |s| s == mark }
  end
end
