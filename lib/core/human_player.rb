require "core/player"

class HumanPlayer < Player
  def initialize(ui_builder, options = {})
    super(ui_builder)
    @options = options
  end

  def request_move(board)
    move = build_ui(board, @options).request_move
    report_move(move)
    move
  end
end
