class Player

  def initialize(ui_builder)
    @ui_builder = ui_builder
  end

  def add_move_reporter(move_reporter)
    @move_reporter = move_reporter
  end

  private
  def build_ui(board, options = {})
    @ui_builder.set_board(board).set_options(options).build
  end

  def report_move(move)
    @move_reporter.call(move) if @move_reporter
  end
end
