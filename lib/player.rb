class Player
  def initialize(ui_builder)
    @ui_builder = ui_builder
  end

  def request_move(board)
    ui = build_ui(board)
    ui.print_board
    ui.request_move
  end

  private
  def build_ui(board)
    @ui_builder.set_board(board).build
  end
end
