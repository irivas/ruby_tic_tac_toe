class Player

  attr_writer :move_reporter

  def initialize(ui_builder)
    @ui_builder = ui_builder
  end

  private
  def build_ui(board, options = {})
    @ui_builder.set_board(board).set_options(options).build
  end

  def report_move(move)
    @move_reporter.call(move) if @move_reporter
  end
end
