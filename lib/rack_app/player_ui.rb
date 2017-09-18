require "rack"
require "rack_app/board_formatter"
require "rack_app/html_wrapper"

module RackApp
  class PlayerUI
    def initialize(board)
      @board = board
      @page_builder = RackApp::HTMLWrapper.new
    end

    def request_move
      page = build_page
      response = Rack::Response.new(page.body)
      page.headers.each(&response.method(:set_header))
      response
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
        .build
    end

    def build_board
      RackApp::BoardFormatter.new(@board).format
    end

    def build_form
      ["<form id=\"game_form\">",
       "<input type=\"hidden\" id=\"moves\" name=\"moves\" value=\"#{board_moves}\">",
       "<input type=\"hidden\" id=\"move\" name=\"move\">",
       "</form>"]
    end

    def board_moves
      @board.moves.join(",")
    end

    StylesheetInclude = "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/tic_tac_toe.css\">"
    StartContainer = "<div class=\"container\">"
    EndContainer = "</div>"
    JavaScriptInclude = "<script src=\"js/tic_tac_toe.js\"><\/script>"
  end
end
