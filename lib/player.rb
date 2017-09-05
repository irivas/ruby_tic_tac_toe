class Player
  def initialize(ui_builder)
    @ui_builder = ui_builder
  end

  def request_move(board)
    build_ui(board).request_move
  end

  private
  def build_ui(board)
    @ui_builder.set_board(board).build
  end
end
