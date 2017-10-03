require "console_ui/board_formatter"

module ConsoleUI
  class GameUI
    def initialize(options)
      @input = options[:input]
      @output = options[:output]
      @game = options[:game]
    end

    def next_move
      clear_screen
      print_board
      get_next_players_move
    end

    private

    def clear_screen
      system("clear")
    end

    def print_board
      @output.puts(formatted_board)
    end

    def formatted_board
      ConsoleUI::BoardFormatter.new(board).format
    end

    def board
      @game.board
    end

    def get_next_players_move
      next_player_type == :human ? get_human_move : get_computer_move
    end
    
    def get_human_move
      print_move_request
      get_move_response
    end

    def print_move_request
      @output.puts("#{next_player.upcase}'s move:")
    end

    def next_player
      board.next_player
    end

    def get_move_response
      input = @input.gets.chomp
      valid_input?(input) ? input.to_i : try_move_reponse_again
    end

    def valid_input?(input)
      input.match(/^\d$/) && board.valid_move?(input.to_i)
    end

    def try_move_reponse_again
      print_invalid_input
      get_move_response
    end

    def print_invalid_input
      @output.puts("Boom: invalid input")
    end
    
    def next_player_type
      @game.next_player.type
    end

    def get_computer_move
      @game.next_player.get_move(board)
    end
  end
end
