require "core/player"

class ComputerPlayer < Player
  def initialize(ui_builder, algorithm, sleep_time: 0, max_depth: 3)
    super(ui_builder)
    @algorithm = algorithm
    @sleep_time = sleep_time
    @max_depth = max_depth
  end

  def request_move(board)
    print_board(board)
    select_move(board)
  end

  private
  def print_board(board)
    ui = build_ui(board)
    ui.clear_screen
    ui.print_board
  end

  def select_move(board)
    sleep(@sleep_time)
    @algorithm.new(board, max_depth: @max_depth).execute.move
  end
end
