$: << File.join(File.dirname(__FILE__), '..', 'lib')

def build_board(*squares)
  squares.reduce(Board.new) { |board, square| board.move(square) }
end
