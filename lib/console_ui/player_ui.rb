require "console_ui/ui"

class PlayerUI < UI
  def request_move
    clear_screen
    print_board
    get_player_move
  end

  private
  def get_player_move
    print_request_move_prompt
    get_player_move_input
  end

  def print_request_move_prompt
    @output.puts("#{next_player}'s move:")
  end

  def next_player
    board.next_player.upcase
  end

  def get_player_move_input
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
