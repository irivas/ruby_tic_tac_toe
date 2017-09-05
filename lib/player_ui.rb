require 'board_formatter'

class PlayerUI
  def initialize(board, input: $stdin, output: $stdout)
    @board = board
    @input = input 
    @output = output 
  end

  def print_board
    @output.puts(formatted_board)
  end

  def request_move
    print_request_move_prompt
    get_player_move
  end

  def clear_screen
    system("clear")
  end

  private
  def board
    @board
  end

  def formatted_board
    BoardFormatter.new(board).format
  end

  def print_request_move_prompt
    @output.puts("#{next_player}'s move:")
  end

  def next_player
    board.next_player.upcase
  end

  def get_player_move
    input = @input.gets.chomp
    if valid_input?(input)
      input.to_i
    else
      print_invalid_input
      get_player_move
    end
  end

  def valid_input?(input)
    input.match(/^\d$/) && board.valid_move?(input.to_i)
  end

  def print_invalid_input
    @output.puts("Boom: invalid input")
  end
end
