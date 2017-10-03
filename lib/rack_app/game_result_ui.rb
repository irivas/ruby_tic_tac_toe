require "rack"
require "rack_app/board_formatter"
require "rack_app/html_wrapper"

module RackApp
  class GameResultUI 

    StylesheetInclude = "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/tic_tac_toe.css\">"
    StartContainer = "<div class=\"container\">"
    EndContainer = "</div>"

    def initialize(board)
      @board = board
      @response_builder  = RackApp::HTMLWrapper.new
    end

    def build
      @response_builder 
        .append_to_head(StylesheetInclude)
        .append_to_body(StartContainer)
        .append_to_body(build_board)
        .append_to_body(result_message)
        .append_to_body(EndContainer)
        .build
    end

    private

    def build_board
      RackApp::BoardFormatter.new(@board).format
    end

    def result_message
      ["<div class=\"result_message\">",
        "<div class=\"headline\">",
        result_text,
        "</div>",
        "<div class=\"play_again\">",
        "<a href=\"/index.html\">",
        "play again",
        "</a>",
        "</div>",
        "</div>"].join("")
    end

    def result_text
      @board.winner? ? "#{get_winner} wins!" : "It's a draw!"
    end

    def get_winner
      @board.winner.upcase
    end

  end
end
