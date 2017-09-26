require "rack"
require "rack_app/board_formatter"
require "rack_app/html_wrapper"

module RackApp
  class PlayerUI
    def initialize(board, options = {})
      @board = board
      @move = options.fetch(:move, nil) 
      @player_x_type = options.fetch(:player_x_type, :human)
      @player_o_type = options.fetch(:player_o_type, :human)
      @page_builder = RackApp::HTMLWrapper.new
    end

    def request_move
      build_page
      build_response
    end

    def print_board
      build_page
      build_response
    end

    private
    
    def build_page
      @page_builder
        .append_to_head(StylesheetInclude)
        .append_to_body(StartContainer)
        .append_to_body(build_board)
        .append_to_body(EndContainer)
        .append_to_body(build_form)
        .append_to_body(JavaScriptInclude)
    end

    def build_board
      RackApp::BoardFormatter.new(@board).format
    end

    def build_form
      ["<form id=\"game_form\">",
        build_player_type_input,
        "<input type=\"hidden\" id=\"moves\" name=\"moves\" value=\"#{board_moves}\">",
        build_move_input,
        "</form>"]
    end

    def build_player_type_input
      ["<input type=\"hidden\" id=\"next_player_type\" name=\"next_player_type\" value=\"#{next_player_type}\">",
       "<input type=\"hidden\" id=\"player_x_type\" name=\"player_x_type\" value=\"#{@player_x_type}\">",
       "<input type=\"hidden\" id=\"player_o_type\" name=\"player_o_type\" value=\"#{@player_o_type}\">",
      ].join("")
    end

    def next_player_type
      @board.next_player == :x ? @player_x_type : @player_o_type;
    end

    def board_moves
      @board.moves.join(",")
    end

    def build_move_input
      "<input type=\"hidden\" id=\"move\" name=\"move\" value=\"#{@move}\">"
    end

    def build_response
      page = @page_builder.build
      response = Rack::Response.new(page.body)
      page.headers.each(&response.method(:set_header))
      response
    end

    StylesheetInclude = "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/tic_tac_toe.css\">"
    StartContainer = "<div class=\"container\">"
    EndContainer = "</div>"
    JavaScriptInclude = "<script src=\"js/tic_tac_toe.js\"><\/script>"
  end
end
