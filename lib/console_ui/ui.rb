require "console_ui/board_formatter"

class UI
  def initialize(board: nil, input: $stdin, output: $stdout)
    @board = board
    @input = input 
    @output = output 
  end

  def print_board
    @output.puts(formatted_board)
  end

  def clear_screen
    system("clear")
  end

  private
  def formatted_board
    BoardFormatter.new(board).format
  end

  def board
    @board
  end
end
