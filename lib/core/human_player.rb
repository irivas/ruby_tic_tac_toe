require "core/player"

class HumanPlayer < Player
  def request_move(board)
    move = build_ui(board).request_move
    report_move(move)
    move
  end
end
