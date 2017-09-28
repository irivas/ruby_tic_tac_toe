require "console_ui/board_formatter"

module ConsoleUI
  class SimpleGameResultUI
    def initialize(options)
      @game = options[:game]
      @output = options[:output]
    end

    def render
      clear_screen
      print_board
      print_result
    end

    private
    
    def clear_screen
      system("clear")
    end

    def print_board
      @output.puts(formatted_board)
    end

    def formatted_board
      ConsoleUI::BoardFormatter.new(@game.board).format
    end

    def print_result
      @output.puts(message)
    end

    def message
      board.winner? ? winning_message : draw_message
    end
    
    def winning_message
      "#{winner} Wins!"
    end

    def draw_message
      "It's a draw!"
    end

    def winner
      board.winner.upcase
    end

    def board
      @game.board
    end
  end
end
