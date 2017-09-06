require "Player"

class HumanPlayer < Player
  def request_move(board)
    build_ui(board).request_move
  end
end
