require "core/player"

class ComputerPlayer < Player
  def initialize(ui_builder, algorithm, options = {})
    super(ui_builder)
    @algorithm = algorithm
    @options = options
    @sleep_time = options.fetch(:sleep_time, 0)
    @max_depth = options.fetch(:max_depth, 4)
  end

  def request_move(board)
    move = select_move(board)
    build_ui(board, @options.merge({move: move})).print_board
    report_move(move)
  end

  private

  def select_move(board)
    sleep(@sleep_time)
    @algorithm.new(board, max_depth: @max_depth).execute.move
  end
end
